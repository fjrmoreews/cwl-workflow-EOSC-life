class: CommandLineTool
cwlVersion: v1.0
id: classifyotu
baseCommand: [mothur]
arguments:
  - classifyotu.batch
inputs:
  - id: list
    type: File
  - id: taxonomy
    type: File
  - id: name
    type: File?
  - id: count
    type: File?
  - id: cutoff
    type: int?
    default: 60
  - id: label
    type: string?
  - id: probs
    type: boolean?
    default: true
  - id: threshold
    type: int?
  - id: basis
    type: string?
    default: "otu"
  - id: group
    type: File?
  - id: persample
    type: boolean?
    default: false
  - id: relabund
    type: string?
    default: "F"
  - id: output
    type: string?
    default: "detail"
  - id: printlevel
    type: float
    default: -1
outputs:
  - id: taxsummary
    type: File
    outputBinding:
      glob: "*.tax.summary"
  - id: tax
    type: File
    outputBinding:
      glob: "*.taxonomy"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.43.0--hd76352b_0

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.list)
      - entryname: classifyotu.batch
        entry: |-

          ${
               var param = "classify.otu(list=./"+(inputs.list.basename)+", taxonomy="+(inputs.taxonomy.path)+", cutoff="+(inputs.cutoff)+", persample="+(inputs.persample)+", relabund="+(inputs.relabund)+", output="+(inputs.output)+", printlevel="+(inputs.printlevel)

              if (inputs.name!=null){
                param+=",name="+(inputs.name.path)
              }
              if (inputs.count!=null){
                param+=",count="+(inputs.count.path)
              }
              if (inputs.label!=null){
                param+=",label="+(inputs.label)
              }
              if (inputs.probs!=null){
                param+=",probs="+(inputs.probs)
              }

              if (inputs.threshold!=null){
                param+=",threshold="+(inputs.threshold)
              }

              if (inputs.basis!=null){
                param+=",basis="+(inputs.basis)
              }
              param+=")"
              return param;
            }


label: classifyOTU
