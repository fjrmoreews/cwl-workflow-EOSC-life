class: CommandLineTool
cwlVersion: v1.0
id: makegroup

baseCommand: [mothur]
arguments:
  - makegroup.batch

inputs:
  - id: fasta
    type: File[]

  - id: group
    type: string[]

outputs:
  - id: groups
    type: File
    outputBinding:
        glob: "outputFilesMakeGroup/*.groups"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.43.0--hd76352b_0

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fasta)
      - entryname: makegroup.batch
        entry: |-
              set.dir(output=./outputFilesMakeGroup)
              ${
              var f=''
              var g=''
              for (var i=0; i< inputs.fasta.length; i++){
                f+= ("./" + inputs.fasta[i].basename + "-")
                g+= (inputs.group[i] + "-")
              }
              g=g.slice(0,-1)
              f=f.slice(0,-1)
              return "make.group(fasta='"+f+"', groups= "+g+", output=groupmap.groups)";
              }
