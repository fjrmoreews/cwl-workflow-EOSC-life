class: Workflow
cwlVersion: v1.0
id: mothur
label: mothur
inputs:
  - id: template
    type: File
  - id: filestomerge
    type: 'File[]'
  - id: group
    type: 'string[]'
  - id: trump
    type: string
  - id: diffs
    type: int?
  - id: template_1
    type: File
  - id: taxonomy
    type: File
  - id: label
    type: string?
  - id: minlength
    type: int?
  - id: maxlength
    type: int?
  - id: maxhomop
    type: int?
  - id: maxambig
    type: int?
  - id: cutoffClusterSplit
    type: float?
  - id: methodClusterSplit
    type: string?

outputs:
#  - id: fastaoutpreclust
#    outputSource:
#      - precluster/fastaout
#    type: File
#  - id: fastaoutfilter
#    outputSource:
#      - filterseqs/fastaout
#    type: File
  - id: output_1
    outputSource:
      - summaryseqs/output
    type: File
#  - id: output
#    outputSource:
#      - summaryseqs_1/output
#    type: File
  - id: tax
    outputSource:
      - classifyotu/tax
    type: File
  - id: taxsummary
    outputSource:
      - classifyotu/taxsummary
    type: File
  - id: shared
    outputSource:
      - makeshared/shared
    type: File
  - id: taxonomy_1seqs
    outputSource:
      - classifyseqs/taxonomy
    type: File
  - id: listclustersplit
    outputSource:
      - clustersplit/list
    type: File
steps:
  - id: merge_files
    in:
      - id: filestomerge
        source:
          - filestomerge
    out:
      - id: mergedfile
    run: ./mergefiles.cwl
  - id: makegroup
    in:
      - id: fasta
        source:
          - filestomerge
      - id: group
        source:
          - group
    out:
      - id: groups
    run: ./makegroup.cwl
  - id: uniqueseqs
    in:
      - id: fasta
        source: merge_files/mergedfile
    out:
      - id: unique
      - id: name
    run: ./uniqueseqs.cwl
  - id: countseqs
    in:
      - id: name
        source: uniqueseqs/name
      - id: groups
        source: makegroup/groups
    out:
      - id: count
    run: ./countseqs.cwl
  - id: alignseqs
    in:
      - id: candidate
        source: screenseqs_1/fastagoodout
      - id: template
        source: template
    out:
      - id: align
      - id: report
      - id: flip
    run: ./alignseqs.cwl
  - id: summaryseqs
    in:
      - id: fasta
        source: uniqueseqs/unique
      - id: count
        source: countseqs/count
    out:
      - id: unique
      - id: output
    run: ./summaryseqs.cwl
  - id: summaryseqs_1
    in:
      - id: fasta
        source: screenseqs_1/fastagoodout
      - id: count
        source: screenseqs_1/countgoodout
    out:
      - id: unique
      - id: output
    run: ./summaryseqs.cwl
  - id: summaryseqs_2
    in:
      - id: fasta
        source: alignseqs/align
      - id: count
        source: screenseqs_1/countgoodout
    out:
      - id: unique
      - id: output
    run: ./summaryseqs.cwl
  - id: filterseqs
    in:
      - id: fasta
        source: screenseqs_2/fastagoodout
      - id: trump
        source: trump
    out:
      - id: fastaout
    run: ./filterseqs.cwl
  - id: precluster
    in:
      - id: fasta
        source: filterseqs/fastaout
      - id: count
        source: screenseqs_2/countgoodout
      - id: diffs
        source: diffs
    out:
      - id: fastaout
      - id: countout
      - id: map
    run: ./precluster.cwl
  - id: classifyseqs
    in:
      - id: fasta
        source: precluster/fastaout
      - id: template
        source: template_1
      - id: taxonomy
        source: taxonomy
      - id: count
        source: precluster/countout
    out:
      - id: summary
      - id: taxonomy
    run: ./classifyseqs.cwl
  - id: clustersplit
    in:
      - id: fasta
        source: precluster/fastaout
      - id: taxonomy
        source: classifyseqs/taxonomy
      - id: count
        source: precluster/countout
      - id: method
        source: methodClusterSplit
      - id: cutoff
        source: cutoffClusterSplit
    out:
      - id: list
    run: ./clustersplit.cwl
  - id: makeshared
    in:
      - id: list
        source: clustersplit/list
      - id: count
        source: precluster/countout
      - id: label
        source: label
    out:
      - id: shared
    run: ./makeshared.cwl
  - id: classifyotu
    in:
      - id: list
        source: clustersplit/list
      - id: taxonomy
        source: classifyseqs/taxonomy
      - id: label
        source: label
      - id: count
        source: precluster/countout
    out:
      - id: taxsummary
      - id: tax
    run: ./classifyotu.cwl
    label: classifyOTU
  - id: getend
    in:
      - id: summary
        source: summaryseqs_2/output
    out:
      - id: value
    run: ./getend.cwl
  - id: getstart
    in:
      - id: summary
        source: summaryseqs_2/output
    out:
      - id: value
    run: ./getstart.cwl
  - id: screenseqs_2
    in:
      - id: fasta
        source: alignseqs/align
      - id: count
        source: screenseqs_1/countgoodout
      - id: start
        source: getstart/value
      - id: end
        source: getend/value
    out:
      - id: fastagoodout
      - id: fastabadout
      - id: countgoodout
    run: ./screenseqs.cwl
  - id: screenseqs_1
    in:
      - id: fasta
        source: uniqueseqs/unique
      - id: minlength
        source: minlength
      - id: maxlength
        source: maxlength
      - id: maxambig
        source: maxambig
      - id: maxhomop
        source: maxhomop
      - id: count
        source: countseqs/count
    out:
      - id: fastagoodout
      - id: fastabadout
      - id: countgoodout
    run: ./screenseqs.cwl
requirements: []
