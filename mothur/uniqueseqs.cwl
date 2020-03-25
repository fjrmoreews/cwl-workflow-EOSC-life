class: CommandLineTool
cwlVersion: v1.0
id: uniqueseqs

baseCommand: [mothur]
arguments:
  - uniqueseqs.batch
inputs:
  - id: fasta
    type: File

outputs:
  - id: unique
    type: File
    outputBinding:
      glob: "outputFilesUniqueSeqs/*.fasta"

  - id: name
    type: File
    outputBinding:
      glob: "outputFilesUniqueSeqs/*.names"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.43.0--hd76352b_0

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: uniqueseqs.batch
        entry: |-
          set.dir(output=./outputFilesUniqueSeqs)
          unique.seqs(fasta=$(inputs.fasta.path))
