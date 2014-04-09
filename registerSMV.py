#!/usr/bin/python
from optparse import OptionParser
import requests
from bs4 import  BeautifulSoup
import csv
import getpass
import datetime

def GetSmvWikiPage():
	r = requests.get('https://wiki.eng.sonicwall.com/wiki/SuperMassive/SuperMassiveTB/SHDEVSM1',verify=False);
	print r.content;


def main():
	GetSmvWikiPage();

if __name__ == '__main__':
	main();
