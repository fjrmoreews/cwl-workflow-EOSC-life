class: CommandLineTool
cwlVersion: v1.0
id: screenseqs

baseCommand: [mothur]
arguments:
  - screenseqs.batch
inputs:
  - id: fasta
    type: File
  - id: minlength
    type: int?
#    default: 225
  - id: maxlength
    type: int?
#    default: 275
  - id: maxambig
    type: int?
#    default: 0
  - id: maxhomop
    type: int?
#    default: 8
  - id: count
    type: File?
  - id: start
    type: int?
  - id: end
    type: int?
  - id: group
    type: File?
  - id: name
    type: File?
outputs:
  - id: fastagoodout
    type: File
    outputBinding:
      glob: "outputFilesscreenseqs/$(inputs.fasta.nameroot).good.*"
  - id: fastabadout
    type: File
    outputBinding:
      glob: "outputFilesscreenseqs/*.bad.accnos"
  - id: countgoodout
    type: File
    outputBinding:
      glob: "outputFilesscreenseqs/*.good.count_table"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.43.0--hd76352b_0
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.count)
      - $(inputs.fasta)
      - $(inputs.group)
      - $(inputs.name)
      - entryname: screenseqs.batch
        entry: |-
              set.dir(output=./outputFilesscreenseqs)
                ${ var cmd = "screen.seqs(fasta=./"+(inputs.fasta.basename)

                   if (inputs.start!=null){
                     cmd+=",start="+(inputs.start)
                   }
                   if (inputs.end!=null){
                     cmd+=",end="+(inputs.end)
                   }

                   if (inputs.count!=null){
                     cmd+=",count=./"+(inputs.count.basename)
                   }
                   if (inputs.name!=null){
                     cmd+=",name=./"+(inputs.name.basename)
                   }
                   if (inputs.group!=null){
                     cmd+=",group=./"+(inputs.group.basename)
                   }
                   if (inputs.maxambig!=null){
                     cmd+=",maxambig="+(inputs.maxambig)
                   }
                   if (inputs.minlength!=null){
                     cmd+=",minlength="+(inputs.minlength)
                   }
                   if (inputs.maxlength!=null){
                     cmd+=",maxlength="+(inputs.maxlength)
                   }
                   if (inputs.maxhomop!=null){
                     cmd+=",maxhomop="+(inputs.maxhomop)
                   }
                   cmd+=")"
                   return cmd
                }
