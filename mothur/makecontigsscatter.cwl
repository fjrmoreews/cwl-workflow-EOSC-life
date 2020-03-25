class: Workflow
cwlVersion: v1.0
id: makecontigsscatter
label: makecontigsscatter

requirements:
  - class: ScatterFeatureRequirement

inputs:
  - id: filesR1
    type: File[]

  - id: filesR2
    type: File[]

outputs:
  - id: trims
    type: File[]
    outputSource:
      - makecontigs/trim
  - id: reports
    type: File[]
    outputSource:
      - makecontigs/report
  - id: scraps
    type: File[]
    outputSource:
      - makecontigs/scrap

steps:
   - id: makecontigs
     scatter: [fileR1, fileR2]
     scatterMethod: "dotproduct"
     in:
       fileR1: filesR1
       fileR2: filesR2
     out:
       - id: trim
       - id: report
       - id: scrap
     run: ./makecontigs.cwl
     label: makecontigs
