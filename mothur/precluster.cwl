class: CommandLineTool
cwlVersion: v1.0
id: precluster

baseCommand: [mothur]
arguments:
  - precluster.batch

inputs:
  - id: fasta
    type: File
  - id: name
    type: File?
  - id: count
    type: File?
  - id: diffs
    type: int?
    default: 1

outputs:
  - id: fastaout
    type: File
    outputBinding:
        glob: "*precluster.fasta"
  - id: countout
    type: File
    outputBinding:
        glob: "*precluster.count_table"
  - id: map
    type: File[]
    outputBinding:
        glob: "*.map"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.43.0--hd76352b_0


requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fasta)
      - $(inputs.name)
      - $(inputs.count)
      - entryname: precluster.batch
        entry: |-
            ${
               var cmd = "pre.cluster(fasta=./"+(inputs.fasta.basename)+",diffs="+(inputs.diffs)
               if ((inputs.name!=null)){
                 cmd+=",name=./"+(inputs.name.basename)
               }
               if (inputs.count!=null){
                 cmd+=",count=./"+(inputs.count.basename)
               }
               cmd+=")"
               return cmd
            }
