class: CommandLineTool
cwlVersion: v1.0
id: clustersplit
baseCommand: [mothur]
arguments:
  - clustersplit.batch
inputs:
  - id: splitmethod
    type: string?
    doc: "classify, fasta or distance (default)"
    default: "distance"

  - id: fasta
    type: File?
  - id: phylip
    type: File?
  - id: taxonomy
    type: File?

  - id: count
    type: File?

  - id: method
    type: string?
    default: "opti"
    doc: "opticlust (opti), average neighbor (average), furthest neighbor (furthest), nearest neighbor (nearest), Vsearch agc (agc), Vsearch dgc (dgc)."

  - id: metric
    type: string?
    default: 'mcc'
    doc: "Matthews correlation coefficient (mcc), sensitivity (sens), specificity (spec), true positives + true negatives (tptn), false positives + false negatives (fpfn), true positives (tp), true negative (tn), false positive (fp), false negative (fn), f1score (f1score), accuracy (accuracy), positive predictive value (ppv), negative predictive value (npv), false discovery rate (fdr). Default=mcc."

  - id: large
    type: string?
    default: 'F'

  - id: cutoff
    type: float?
    default: 0.03

outputs:

  - id: list
    type: File
    outputBinding:
      glob: "*.list"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.43.0--hd76352b_0
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fasta)
      - $(inputs.count)
      - entryname: clustersplit.batch
        entry: |-
               cluster.split(fasta=./$(inputs.fasta.basename), count=./$(inputs.count.basename), taxonomy=$(inputs.taxonomy.path), metric=$(inputs.metric), cutoff=$(inputs.cutoff), large=$(inputs.large), method=$(inputs.method))
