class: CommandLineTool
cwlVersion: v1.0
id: alignseqs

baseCommand: [mothur]
arguments:
  - alignseqs.batch

inputs:
  - id: candidate
    type: File
  - id: template
    type: File
  - id: kmer
    type: int
    default: 8
  - id: align
    type: string
    default: "needleman"
  - id: flip
    type: string
    default: t
  - id: threshold
    type: float
    default: 0.50
outputs:
  - id: align
    type: File
    outputBinding:
      glob: "outputFilesAlignSeqs/*.align"
  - id: report
    type: File
    outputBinding:
      glob: "outputFilesAlignSeqs/*.report"
  - id: flip
    type: File
    outputBinding:
      glob: "outputFilesAlignSeqs/*.flip.accnos"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.43.0--hd76352b_0

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.template)
      - entryname: alignseqs.batch
        entry: |-
              set.dir(output=./outputFilesAlignSeqs)
              align.seqs(candidate= $(inputs.candidate.path), template=./$(inputs.template.basename) , align= $(inputs.align), ksize= $(inputs.kmer), flip=$(inputs.flip), threshold=$(inputs.threshold))
