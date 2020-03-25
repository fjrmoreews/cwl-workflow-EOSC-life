class: CommandLineTool
cwlVersion: v1.0
id: summaryseqs

baseCommand: [mothur]
arguments:
  - summaryseqs.batch
inputs:
  - id: fasta
    type: File

  - id: count
    type: File

outputs:
  - id: unique
    type: File
    outputBinding:
      glob: "outputFilessummaryseqs/*.summary"
  - id: output
    type: stdout

stdout: out_summaryseqs.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.43.0--hd76352b_0

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: summaryseqs.batch
        entry: |-
          set.dir(output=./outputFilessummaryseqs)
          summary.seqs(fasta=$(inputs.fasta.path), count=$(inputs.count.path))
