class: CommandLineTool
cwlVersion: v1.0
id: countseqs

baseCommand: [mothur]
arguments:
  - countseqs.batch
inputs:
  - id: name
    type: File

  - id: groups
    type: File

outputs:
  - id: count
    type: File
    outputBinding:
      glob: "outputFilesCountSeqs/*.count_table"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.43.0--hd76352b_0

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: countseqs.batch
        entry: |-
              set.dir(output=./outputFilesCountSeqs)
              count.seqs(name=$(inputs.name.path),group=$(inputs.groups.path))
