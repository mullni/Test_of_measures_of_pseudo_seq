#!/usr/local/bin/python2.7
# encoding: utf-8
'''
convert_text_file -- shortdesc

convert_text_file is a description

It defines classes_and_methods

@author:     user_name

@copyright:  2022 organization_name. All rights reserved.

@license:    license

@contact:    user_email
@deffield    updated: Updated
'''

import sys
import os

from argparse import ArgumentParser
from argparse import RawDescriptionHelpFormatter

__all__ = []
__version__ = 0.1
__date__ = '2022-02-10'
__updated__ = '2022-04-17'

DEBUG = 1
TESTRUN = 0
PROFILE = 0


class CLIError(Exception):
    '''Generic exception to raise and log different fatal errors.'''

    def __init__(self, msg):
        super(CLIError).__init__(type(self))
        self.msg = "E: %s" % msg

    def __str__(self):
        return self.msg

    def __unicode__(self):
        return self.msg


def convert_text_file(textFile, charSeparator, outputFile, charLimitList):
    theOutputLine = ""
    theTotalCharIdx = 1
    theOneLine = ""

    with open(textFile) as fp:
        for textLine in fp:
            # Remove all whitespaces inside the string
            textLine.strip()
            textLine = textLine.replace(" ", "")
            textLine = textLine.replace('\n', '').replace('\r', '')

            theOneLine = theOneLine + textLine

    theOneLineLength = len(theOneLine)

    # Put the charSeparator after each char in the string
    theCharIdx = 1
    for theChar in theOneLine:
        if theCharIdx == theOneLineLength:
            theNewLineTmp = theChar
        else:
            theNewLineTmp = theChar + charSeparator

        if theOutputLine == "":
            theOutputLine = theNewLineTmp
        else:
            theOutputLine = theOutputLine + theNewLineTmp

        # Increment theCharIdx
        theCharIdx = theCharIdx + 1
        theTotalCharIdx = theTotalCharIdx + 1

        # Save the sub-result if needed
        if theTotalCharIdx in charLimitList:
            # print("theTotalCharIdx: " + str(theTotalCharIdx))
            # Build the output file name
            outputFileTmp = outputFile + "_" + str(theTotalCharIdx)

            # Delete the file if exists
            if os.path.exists(outputFileTmp):
                os.remove(outputFileTmp)

            # Remove the charSeparator at the end if there is
            theOutputLineTmp = theOutputLine
            if theOutputLineTmp.endswith(charSeparator):
                theOutputLineTmp = theOutputLineTmp[:-1]

            # Save the string in the file
            outputFileTmpId = open(outputFileTmp, "w")
            outputFileTmpId.write(theOutputLineTmp)
            outputFileTmpId.close()

            # Delete theTotalCharIdx from charLimitList
            charLimitList.remove(theTotalCharIdx)

    return theOutputLine


def main(argv=None):  # IGNORE:C0111
    '''Command line options.'''

    if argv is None:
        argv = sys.argv
    else:
        sys.argv.extend(argv)

    try:
        # Setup argument parser
        parser = ArgumentParser(description="", formatter_class=RawDescriptionHelpFormatter)

        parser.add_argument('-textFile',
                            help=("The TXT file to be converted \n" +
                                  "\n\n"))

        parser.add_argument('-outputFile',
                            help=("The output file to save the conversation result \n" +
                                  "\n\n"))

        parser.add_argument('-charSeparator',
                            help=("The character to be used between 2 chars in the given TXT file \n" +
                                  "\n\n"))

        # Process arguments
        args = parser.parse_args()

        if args.textFile is None:
            print("Error, no TXT file is specified")
            return 1

        if args.outputFile is None:
            print("Error, no output file is specified")
            return 1

        if args.charSeparator is None:
            print("Error, no char seprator is specified")
            return 1

        charLimitList = [50000]
        _convertedOneLineData = convert_text_file(args.textFile, args.charSeparator, args.outputFile, charLimitList)

        # # Put the convertedOneLineData into the given output file
        # if os.path.exists(args.outputFile):
        #     os.remove(args.outputFile)
        #
        # outputFile = open(args.outputFile, "w")
        # outputFile.write(convertedOneLineData)
        # outputFile.close()

        return 0

    except KeyboardInterrupt:
        ### handle keyboard interrupt ###
        return 0


if __name__ == "__main__":
    sys.exit(main())
