class: CommandLineTool
cwlVersion: v1.0
id: merge.files

baseCommand: [mothur]
arguments:
  - mergefiles.batch
inputs:
  - id: filestomerge
    type: File[]

outputs:
  - id: mergedfile
    type: File
    outputBinding:
      glob: "outputFilesMergeFiles/*.fasta"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.43.0--hd76352b_0

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.filestomerge)
      - entryname: mergefiles.batch
        entry: |-
          set.dir(output=./outputFilesMergeFiles)
          merge.files(input=${
                  var r=""
                  for (var i=0; i< inputs.filestomerge.length; i++){
                    r+=("./"+ inputs.filestomerge[i].basename + "-")
                  }
                  return r.slice(0, -1);
                 }, output = merge.fasta )
