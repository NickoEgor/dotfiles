#!/usr/bin/env python3
import argparse
import json
import os
import requests
import subprocess
import sys
from html.parser import HTMLParser

WRDHUNT = 'https://wooordhunt.ru/word/{}'


class WrdParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.result = []
        self.accepted = False

        self.extended = {}
        self.in_h4 = False
        self.h4_title = ""
        self.in_div = False
        self.in_i = False
        self.in_lvl = 0
        self.last_lvl = 0

        self.collocations = []
        self.in_block = False

    def handle_starttag(self, tag, attrs):
        # parse basic translation options
        if tag == 'span':
            for name, value in attrs:
                if name == 'class' and value == 't_inline_en':
                    self.accepted = True
        # parse type of extended translations (verb, noun, adj, ...)
        elif tag == 'h4':
            self.in_h4 = True
        # parse examples of one type of translation
        elif tag == 'div' and self.in_h4 == True:
            if self.in_div:
                self.in_lvl += 1
            else:
                for name, value in attrs:
                    if name == 'class' and value == 'tr':
                        self.in_div = True
        # parse small notes
        elif tag == 'i' and self.in_h4:
            self.in_i = True
        # parse collocations
        elif tag == 'div':
            for name, value in attrs:
                if name == 'class' and value == 'block phrases':
                    self.in_block = True
                    self.collocations.append("")
        # newlines in translations
        elif tag == 'br' and self.in_h4:
            self.extended[self.h4_title][-1] = \
                self.extended[self.h4_title][-1].strip()
            self.extended[self.h4_title].append("")
        # newlines in collocations
        elif tag == 'br' and self.in_block:
            self.collocations[-1] = self.collocations[-1].strip()
            self.collocations.append("")
        # remove 'snoska' in translations
        elif tag == 'p' and self.in_block:
            for name, value in attrs:
                if name == 'class' and value == 'snoska':
                    if len(self.collocations[-1].strip()) == 0:
                        self.collocations.pop()
                    self.in_block = False


    def handle_endtag(self, tag):
        if tag == 'div' and self.in_div:
            if self.in_lvl > 0:
                self.in_lvl -= 1
            else:
                if self.extended[self.h4_title][-1] == "":
                    self.extended[self.h4_title].pop()
                self.h4_title = ""
                self.in_h4 = False
                self.in_div = False
                self.last_lvl = 0
                # not checking in_lvl cause it should be 0 now
        elif tag == 'div' and self.in_block:
            if len(self.collocations[-1].strip()) == 0:
                self.collocations.pop()
            self.in_block = False


    def handle_data(self, data):
        # get simple translation
        if self.accepted:
            self.accepted = False
            self.result.append(data)
        # catch header extended examples
        elif self.in_h4 and self.h4_title == "":
            self.h4_title = data.strip()
            self.extended[self.h4_title] = []
        # get one example (extended)
        elif self.in_div:
            data = data.replace('\u2002', ' ')
            # add brackets for <i> elements
            if self.in_i:
                self.in_i = False
                if self.extended[self.h4_title][-1] == "- " and \
                   data.strip()[0] != "(" and data.strip()[-1] != ")":
                    data = "(" + data.strip() + ") "
            # add new example (no empty or useless rows)
            if data != "" and data[0:3] != "??????":
                # check depth level of tags in <div>
                if len(self.extended[self.h4_title]) > 0:
                    self.extended[self.h4_title][-1] += data
                else:
                    self.extended[self.h4_title].append(data)
            self.last_lvl = self.in_lvl
        # get collocation
        elif self.in_block:
            data = data.replace('\u2002', ' ')
            if data != "":
                self.collocations[-1] += data


def init_argparse():
    argparser = argparse.ArgumentParser(description='Translate words from english to russian')
    argparser.add_argument('-e', '--extended', action='store_true', help='Shows extended output')
    outputgroup = argparser.add_mutually_exclusive_group(required=False)
    outputgroup.add_argument('-n', '--notify', action='store_true', help='Uses libnotify to show translation')
    outputgroup.add_argument('-j', '--json', action='store_true', help='Shows output in json')
    inputgroup = argparser.add_mutually_exclusive_group(required=True)
    inputgroup.add_argument('-s', '--selection', action='store_true', help='Uses xsel to get unknown word')
    inputgroup.add_argument('-d', '--dmenu', action='store_true', help='Uses dmenu to input unknown word')
    inputgroup.add_argument('-w', '--word', type=str, help='Word to translate. Passes as argument')
    inputgroup.add_argument('-i', '--input', action='store_true', help='Reads word for translate from stdin')
    return vars(argparser.parse_args())

def get_word(args):
    if args.get('selection'):
        unknown_word = subprocess.check_output("xsel -o", shell=True).decode("utf-8")
        if not unknown_word or unknown_word == '\n':
            unknown_word = subprocess.check_output("xsel -b -o", shell=True).decode("utf-8")
    elif args.get('dmenu'):
        try:
            unknown_word = subprocess.check_output('dmenu -i -p "Enter word to translate" <&-', shell=True)[:-1].decode("utf-8")
        except subprocess.CalledProcessError:
            exit(0)
    elif args.get('input'):
        unknown_word = input().strip()
    else:
        unknown_word = args.get('word')
    return unknown_word

def main():
    args = init_argparse()
    unknown_word = get_word(args)

    if not unknown_word or unknown_word == '\n':
        os.system(MESSAGE.format("Translation", "No input"))
        exit(1)

    response = requests.get(WRDHUNT.format(unknown_word))
    parser = WrdParser()
    parser.feed(response.content.decode("utf-8"))

    if args.get('notify'):
        MESSAGE = 'notify-send -u normal -t 5000 "{}" "{}"'
    else:
        MESSAGE = 'printf "{}\n{}\n"'

    if len(parser.result) < 1:
        os.system(MESSAGE.format(unknown_word, "No result"))
        exit(1)
    else:
        ext = '\n'.join([k + ":\n" + '\n'.join(v) for k, v in
                         parser.extended.items()])

        info = {
            'word': unknown_word,
            'translate': parser.result[0],
            'extended': parser.extended,
            'collocations': parser.collocations
        }
        json_info = json.dumps(info, ensure_ascii=False, indent=2)
        if args.get('json'):
            print(json_info)
        else:
            if args.get('extended'):
                os.system(MESSAGE.format(unknown_word, parser.result[0] + '\n' + ext))
            else:
                os.system(MESSAGE.format(unknown_word, parser.result[0]))
        exit(0)


if __name__ == "__main__":
    main()
