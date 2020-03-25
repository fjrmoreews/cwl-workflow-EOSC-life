class: CommandLineTool
cwlVersion: v1.0

inputs:
  - id: summary
    type: File
    inputBinding:
      position: 3

baseCommand: ["python", "getstart.py"]

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: getstart.py
        entry: |-
          import sys
          import csv
          summaryReader = csv.reader(open(sys.argv[1]), delimiter='\t')
          for row in summaryReader:
              if row:
                  if row[0]=="Median: ":
                      print(row[1])

stdout: start.txt

outputs:
#  start:
#    type: stdout
  value:
    type: int
    outputBinding:
      glob: start.txt
      loadContents: true
      outputEval: $(parseInt(self[0].contents))
