class: CommandLineTool
cwlVersion: v1.0
id: filterseqs

baseCommand: [mothur]
arguments:
  - filterseqs.batch
inputs:
  - id: fasta
    type: File

  - id: trump
    type: string
  - id: vertical
    type: string?
    default: 'T'

outputs:
  - id: fastaout
    type: File
    outputBinding:
        glob: "*.filter.fasta"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.43.0--hd76352b_0

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fasta)
      - entryname: filterseqs.batch
        entry: |-
          filter.seqs(fasta=./$(inputs.fasta.basename), trump=$(inputs.trump), vertical=$(inputs.vertical))
