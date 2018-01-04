# Pitch2Catcher
This Sinatra app is a web interface for the gem Pitcher, a library to interact with OCLC CONTENTdm's Catcher web service. You can use this batch import process to do bulk updating of CONTENTdm metadata via CSV file.

## Installation
Install locally or on a remote server. Your choice.

## Usage
Refer to [this pdf](/public/BatchEditingCONTENTdmRecords.pdf) for information and instructions on the following:
* Requirements, permissions, and limitations of OCLC's Catcher web service
* Batch exporting from CONTENTdm
* Batch editing & compound objects
* Cleaning up data exported from CONTENTdm (includes a little bit of OpenRefine info)
* Preparing for batch import using this tool
..* Preparing your CONTENTdm settings file
..* Preparing your .csv import file
* Batch importing
* Reviewing & re-indexing in CONTENTdm

## Additional Notes
I added a basic http auth in app.rb, which wouldn't be necessary for a local install.
The Catcher web service can be glitchy. For best results, temporarily disable ALL controlled vocabularies for the collection you are editing. 
