class: CommandLineTool
cwlVersion: v1.0
id: classifyseqs

baseCommand: [mothur]
arguments:
  - classifyseqs.batch

inputs:
  - id: fasta
    type: File
  - id: template
    type: File
  - id: taxonomy
    type: File
  - id: count
    type: File

outputs:
  - id: summary
    type: File
    outputBinding:
      glob: "*.summary"
  - id: taxonomy
    type: File
    outputBinding:
      glob: "*.wang.taxonomy"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.43.0--hd76352b_0

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fasta)
      - $(inputs.template)
      - $(inputs.taxonomy)
      - $(inputs.count)
      - entryname: classifyseqs.batch
        entry: |-
                classify.seqs(fasta=./$(inputs.fasta.basename), template=./$(inputs.template.basename),taxonomy=./$(inputs.taxonomy.basename),count=./$(inputs.count.basename))
