class: CommandLineTool
cwlVersion: v1.0
id: makeshared

baseCommand: [mothur]
arguments:
  - makeshared.batch
inputs:
  - id: list
    type: File

  - id: group
    type: File?

  - id: phylip
    type: File?
  - id: count
    type: File?
  - id: biom
    type: File?
  - id: groups
    type: File?
  - id: name
    type: File?
  - id: label
    type: string?

outputs:
  - id: shared
    type: File
    outputBinding:
      glob: "outputFilesmakeshared/*.shared"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.43.0--hd76352b_0

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: makeshared.batch
        entry: |-
          set.dir(output=./outputFilesmakeshared)
          make.shared(list=$(inputs.list.path), count=$(inputs.count.path), label=$(inputs.label))
