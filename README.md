# SAS-eCTD

The eCTD_WordMaterials.zip file contains everything necessary to generate the initial paper for the 2023 PharmaSUG conference.

Download and unzip the file.  To create the PharmaSUG paper:
-	Open eCTD_WordSetup.sas
    - Put the name of the document you want to create
    - Specify the path where you unzipped the file
-	Run eCTD_WordSetup.sas
-	Run eCTD_WordCreateDocument.sas
-	Open the document
    - Follow the instructions in Section 4.3 to insert the Table of Contents
    - Follow the instructions in Section 5.3 to insert the Table of Tables and the Table of Figures

Here's what's in the zip:
- eCTD_WordDocumentInfo.xlsx - a spreadsheet that contains some of the contenct that goes into the document.
- eCTD_WordSetup.sas – sets up the environment for creating the document
    - Note: the first couple lines of this program need to be changed to set the name of the document to be created and to reflect the location where the zip file was unzipped.
- eCTD_WordCreateDocument.sas – creates the PharmaSUG Word document
- Macros folder – the macros used in creating the document.  There are eight SAS macro programs in the folder:
    - BulletedList.sas
    - CleanText.sas
    - DataDrivenSectionText.sas
    - eCTD_Caption.sas
    - eCTD_Heading.sas
    - eCTD_Text.sas
    - LoadTitleAndAbstract.sas
    - MakeBlankStatusTable.sas
- Results folder – contains results of running eCTD_WordCreateDocument.sas
    - the name of the file is set in the eCTD_WordSetup.sas program
    - PharmaSUG 2023 Paper.docx is the document as created by the program
    - PharmaSUG 2023 Paper (expanded).docx is the same document after the Table of Contents, Table of Tables and Table of Figures have been exposed in the Word document.

