class: CommandLineTool
cwlVersion: v1.0

inputs:
  - id: summary
    type: File
    inputBinding:
      position: 3

baseCommand: ["python", "getend.py"]

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: getend.py
        entry: |-
          import sys
          import csv
          summaryReader = csv.reader(open(sys.argv[1]), delimiter='\t')
          for row in summaryReader:
              if row:
                  if row[0]=="Median: ":
                      print(row[2])

stdout: end.txt

outputs:
  value:
    type: int
    outputBinding:
      glob: end.txt
      loadContents: true
      outputEval: $(parseInt(self[0].contents))
