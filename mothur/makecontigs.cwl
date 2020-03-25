class: CommandLineTool
cwlVersion: v1.0
id: mothur

baseCommand: [mothur]
arguments:
  - makecontigs.batch


inputs:
  - id: fileR1
    type: File

  - id: fileR2
    type: File


outputs:
  - id: trim
    type: File
    outputBinding:
      glob: "outputFilesMakeContigs/*.trim.contigs.fasta"
  - id: report
    type: File
    outputBinding:
      glob: "outputFilesMakeContigs/*.contigs.report"
  - id: scrap
    type: File
    outputBinding:
      glob: "outputFilesMakeContigs/*.scrap.contigs.fasta"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.43.0--hd76352b_0

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: makecontigs.batch
        entry: |-
              set.dir(output=./outputFilesMakeContigs)
              make.contigs(ffastq=$(inputs.fileR1.path),rfastq=$(inputs.fileR2.path))
