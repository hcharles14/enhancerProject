library(shiny)
ui<-fluidPage(
  #title
  wellPanel(fluidRow(strong(h1('Find Tissue/Cell-Specific Elements'))),
  #explanation
  fluidRow('This tool aims to find tissue/cell-specific elements like enhancers using ChromHMM chromatin states data from Roadmap Epigenomics Consortium.
   Specify foreground samples, background samples, both cutoffs for foreground samples and background samples, and chromatin states.
   The tool ouputs regions in which the percentage of foreground samples having the chromatin states is equal or greater than the foreground cutoff and 
   the percentage of background samples having the chromatin states is equal or less than the background cutoff. Using 80% as foreground cutoff and 
   20% as background cutoff is sufficient for finding tissue-specific enhancers.')),
  #panel for foreground tissues
  wellPanel(fluidRow(column(6,navlistPanel(title='Foreground Samples',
               tabPanel("Primary Adult Tissue/Cell", 
                        tabPanel('BLOOD','BLOOD',selectInput("f1", NULL,c( 'E062 Primary mononuclear cells from peripheral blood', 'E034 Primary T cells from peripheral blood', 'E045 Primary T cells effector/memory enriched from peripheral blood', 'E044 Primary T regulatory cells from peripheral blood', 'E043 Primary T helper cells from peripheral blood', 'E039 Primary T helper naive cells from peripheral blood', 'E041 Primary T helper cells PMA-I stimulated', 'E042 Primary T helper 17 cells PMA-I stimulated', 'E040 Primary T helper memory cells from peripheral blood 1', 'E037 Primary T helper memory cells from peripheral blood 2', 'E048 Primary T CD8+ memory cells from peripheral blood', 'E038 Primary T helper naive cells from peripheral blood', 'E047 Primary T CD8+ naive cells from peripheral blood', 'E029 Primary monocytes from peripheral blood', 'E035 Primary hematopoietic stem cells', 'E051 Primary hematopoietic stem cells G-CSF-mobilized Male', 'E050 Primary hematopoietic stem cells G-CSF-mobilized Female', 'E036 Primary hematopoietic stem cells short term culture', 'E032 Primary B cells from peripheral blood', 'E046 Primary Natural Killer cells from peripheral blood', 'E030 Primary neutrophils from peripheral blood', 'E124 Monocytes-CD14+ RO01746 Primary Cells'),multiple=TRUE)),
                        tabPanel('BRAIN','BRAIN',selectInput("f2", NULL,c( 'E071 Brain Hippocampus Middle', 'E074 Brain Substantia Nigra', 'E068 Brain Anterior Caudate', 'E069 Brain Cingulate Gyrus', 'E072 Brain Inferior Temporal Lobe', 'E067 Brain Angular Gyrus', 'E073 Brain_Dorsolateral_Prefrontal_Cortex'),multiple=TRUE)),
                        tabPanel('BREAST','BREAST',selectInput("f3", NULL,c( 'E027 Breast Myoepithelial Primary Cells'),multiple=TRUE)),
                        tabPanel('FAT','FAT',selectInput("f4", NULL,c( 'E063 Adipose Nuclei'),multiple=TRUE)),
                        tabPanel('GI_COLON','GI_COLON',selectInput("f5", NULL,c( 'E076 Colon Smooth Muscle', 'E106 Sigmoid Colon', 'E075 Colonic Mucosa'),multiple=TRUE)),
                        tabPanel('GI_DUODENUM','GI_DUODENUM',selectInput("f6", NULL,c( 'E078 Duodenum Smooth Muscle', 'E077 Duodenum Mucosa'),multiple=TRUE)),
                        tabPanel('GI_ESOPHAGUS','GI_ESOPHAGUS',selectInput("f7", NULL,c( 'E079 Esophagus'),multiple=TRUE)),
                        tabPanel('GI_INTESTINE','GI_INTESTINE',selectInput("f8", NULL,c( 'E109 Small Intestine'),multiple=TRUE)),
                        tabPanel('GI_RECTUM','GI_RECTUM',selectInput("f9", NULL,c( 'E103 Rectal Smooth Muscle', 'E101 Rectal Mucosa Donor 29', 'E102 Rectal Mucosa Donor 31'),multiple=TRUE)),
                        tabPanel('GI_STOMACH','GI_STOMACH',selectInput("f10", NULL,c( 'E111 Stomach Smooth Muscle', 'E110 Stomach Mucosa', 'E094 Gastric'),multiple=TRUE)),
                        tabPanel('HEART','HEART',selectInput("f11", NULL,c( 'E104 Right Atrium', 'E095 Left Ventricle', 'E105 Right Ventricle'),multiple=TRUE)),
                        tabPanel('LIVER','LIVER',selectInput("f12", NULL,c( 'E066 Liver'),multiple=TRUE)),
                        tabPanel('LUNG','LUNG',selectInput("f13", NULL,c( 'E096 Lung'),multiple=TRUE)),
                        tabPanel('MUSCLE','MUSCLE',selectInput("f14", NULL,c('E100 Psoas Muscle', 'E108 Skeletal Muscle Female', 'E107 Skeletal Muscle Male'),multiple=TRUE)),
                        tabPanel('OVARY','OVARY',selectInput("f15", NULL,c( 'E097 Ovary'),multiple=TRUE)),
                        tabPanel('PANCREAS','PANCREAS',selectInput("f16", NULL,c( 'E087 Pancreatic Islets', 'E098 Pancreas'),multiple=TRUE)),
                        tabPanel('SPLEEN','SPLEEN',selectInput("f17", NULL,c( 'E113 Spleen'),multiple=TRUE)),
                        tabPanel('THYMUS','THYMUS',selectInput("f18", NULL,c( 'E112 Thymus'),multiple=TRUE)),
                        tabPanel('VASCULAR','VASCULAR',selectInput("f19", NULL,c( 'E065 Aorta'),multiple=TRUE))
               ),
               tabPanel("Primary Fetal Tissue/Cell", 
                        tabPanel('ADRENAL','ADRENAL',selectInput("f20", NULL,c( 'E080 Fetal Adrenal Gland'),multiple=TRUE)),
                        tabPanel('BLOOD','BLOOD',selectInput("f21", NULL,c( 'E033 Primary T cells from cord blood', 'E031 Primary B cells from cord blood'),multiple=TRUE)),
                        tabPanel('BRAIN','BRAIN',selectInput("f22", NULL,c( 'E070 Brain Germinal Matrix', 'E082 Fetal Brain Female', 'E081 Fetal Brain Male'),multiple=TRUE)),
                        tabPanel('GI_INTESTINE','GI_INTESTINE',selectInput("f23", NULL,c( 'E085 Fetal Intestine Small', 'E084 Fetal Intestine Large'),multiple=TRUE)),
                        tabPanel('GI_STOMACH','GI_STOMACH',selectInput("f24", NULL,c( 'E092 Fetal Stomach'),multiple=TRUE)),
                        tabPanel('HEART','HEART',selectInput("f25", NULL,c( 'E083 Fetal Heart'),multiple=TRUE)),
                        tabPanel('KIDNEY','KIDNEY',selectInput("f26", NULL,c( 'E086 Fetal Kidney'),multiple=TRUE)),
                        tabPanel('LUNG','LUNG',selectInput("f27", NULL,c( 'E088 Fetal Lung'),multiple=TRUE)),
                        tabPanel('MUSCLE','MUSCLE',selectInput("f28", NULL,c( 'E089 Fetal Muscle Trunk', 'E090 Fetal Muscle Leg'),multiple=TRUE)),
                        tabPanel('PLACENTA','PLACENTA',selectInput("f29", NULL,c('E099 Placenta Amnion', 'E091 Placenta'),multiple=TRUE)),
                        tabPanel('THYMUS','THYMUS',selectInput("f30", NULL,c( 'E093 Fetal Thymus'),multiple=TRUE))
               ),
               tabPanel("Primary Culture", 
                        tabPanel('BLOOD','BLOOD',selectInput("f31", NULL,c( 'E116 GM12878 Lymphoblastoid Cells', 'E123 K562 Leukemia Cells'),multiple=TRUE)),
                        tabPanel('BONE','BONE',selectInput("f32", NULL,c( 'E129 Osteoblast Primary Cells'),multiple=TRUE)),
                        tabPanel('BRAIN','BRAIN',selectInput("f33", NULL,c( 'E054 Ganglion Eminence derived primary cultured neurospheres', 'E053 Cortex derived primary cultured neurospheres', 'E125 NH-A Astrocytes Primary Cells'),multiple=TRUE)),
                        tabPanel('BREAST','BREAST',selectInput("f34", NULL,c( 'E028 Breast variant Human Mammary Epithelial Cells (vHMEC)', 'E119 HMEC Mammary Epithelial Primary Cells'),multiple=TRUE)),
                        tabPanel('ESC','ESC',selectInput("f35", NULL,c( 'E002 ES-WA7 Cells', 'E008 H9 Cells', 'E001 ES-I3 Cells', 'E015 HUES6 Cells', 'E014 HUES48 Cells', 'E016 HUES64 Cells', 'E003 H1 Cells', 'E024 ES-UCSF4  Cells'),multiple=TRUE)),
                        tabPanel('ESC_DERIVED','ESC_DERIVED',selectInput("f36", NULL,c( 'E007 H1 Derived Neuronal Progenitor Cultured Cells', 'E009 H9 Derived Neuronal Progenitor Cultured Cells', 'E010 H9 Derived Neuron Cultured Cells', 'E013 hESC Derived CD56+ Mesoderm Cultured Cells', 'E012 hESC Derived CD56+ Ectoderm Cultured Cells', 'E011 hESC Derived CD184+ Endoderm Cultured Cells', 'E004 H1 BMP4 Derived Mesendoderm Cultured Cells', 'E005 H1 BMP4 Derived Trophoblast Cultured Cells', 'E006 H1 Derived Mesenchymal Stem Cells'),multiple=TRUE)),
                        tabPanel('FAT','FAT',selectInput("f37", NULL,c( 'E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells', 'E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells'),multiple=TRUE)),
                        tabPanel('IPSC','IPSC',selectInput("f38", NULL,c( 'E020 iPS-20b Cells', 'E019 iPS-18 Cells', 'E018 iPS-15b Cells', 'E021 iPS DF 6.9 Cells', 'E022 iPS DF 19.11 Cells'),multiple=TRUE)),
                        tabPanel('LUNG','LUNG',selectInput("f39", NULL,c( 'E128 NHLF Lung Fibroblast Primary Cells'),multiple=TRUE)),
                        tabPanel('MUSCLE','MUSCLE',selectInput("f40", NULL,c( 'E052 Muscle Satellite Cultured Cells', 'E120 HSMM Skeletal Muscle Myoblasts Cells', 'E121 HSMM cell derived Skeletal Muscle Myotubes Cells'),multiple=TRUE)),
                        tabPanel('SKIN','SKIN',selectInput("f41", NULL,c( 'E055 Foreskin Fibroblast Primary Cells skin01', 'E056 Foreskin Fibroblast Primary Cells skin02', 'E059 Foreskin Melanocyte Primary Cells skin01', 'E061 Foreskin Melanocyte Primary Cells skin03', 'E057 Foreskin Keratinocyte Primary Cells skin02', 'E058 Foreskin Keratinocyte Primary Cells skin03', 'E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells', 'E127 NHEK-Epidermal Keratinocyte Primary Cells'),multiple=TRUE)),
                        tabPanel('STROMAL_CONNECTIVE','STROMAL_CONNECTIVE',selectInput("f42", NULL,c( 'E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells', 'E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells'),multiple=TRUE)),
                        tabPanel('VASCULAR','VASCULAR',selectInput("f43", NULL,c( 'E122 HUVEC Umbilical Vein Endothelial Primary Cells'),multiple=TRUE))
               ),
               tabPanel("Cell Line", 
                        tabPanel('BLOOD','BLOOD',selectInput("f44", NULL,c( 'E115 Dnd41 TCell Leukemia Cell Line'),multiple=TRUE)),
                        tabPanel('CERVIX','CERVIX',selectInput("f45", NULL,c( 'E117 HeLa-S3 Cervical Carcinoma Cell Line'),multiple=TRUE)),
                        tabPanel('LIVER','LIVER',selectInput("f46", NULL,c( 'E118 HepG2 Hepatocellular Carcinoma Cell Line'),multiple=TRUE)),
                        tabPanel('LUNG','LUNG',selectInput("f47", NULL,c( 'E017 IMR90 fetal lung fibroblasts Cell Line', 'E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line'),multiple=TRUE))
               )
               
          )),
          #panel for background tissues
          column(6,navlistPanel(title='Background Samples',
               tabPanel("Primary Adult Tissue/Cell", 
                        tabPanel('BLOOD','BLOOD',selectInput("b1", NULL,c( 'E062 Primary mononuclear cells from peripheral blood', 'E034 Primary T cells from peripheral blood', 'E045 Primary T cells effector/memory enriched from peripheral blood', 'E044 Primary T regulatory cells from peripheral blood', 'E043 Primary T helper cells from peripheral blood', 'E039 Primary T helper naive cells from peripheral blood', 'E041 Primary T helper cells PMA-I stimulated', 'E042 Primary T helper 17 cells PMA-I stimulated', 'E040 Primary T helper memory cells from peripheral blood 1', 'E037 Primary T helper memory cells from peripheral blood 2', 'E048 Primary T CD8+ memory cells from peripheral blood', 'E038 Primary T helper naive cells from peripheral blood', 'E047 Primary T CD8+ naive cells from peripheral blood', 'E029 Primary monocytes from peripheral blood', 'E035 Primary hematopoietic stem cells', 'E051 Primary hematopoietic stem cells G-CSF-mobilized Male', 'E050 Primary hematopoietic stem cells G-CSF-mobilized Female', 'E036 Primary hematopoietic stem cells short term culture', 'E032 Primary B cells from peripheral blood', 'E046 Primary Natural Killer cells from peripheral blood', 'E030 Primary neutrophils from peripheral blood', 'E124 Monocytes-CD14+ RO01746 Primary Cells'),multiple=TRUE)),
                        tabPanel('BRAIN','BRAIN',selectInput("b2", NULL,c( 'E071 Brain Hippocampus Middle', 'E074 Brain Substantia Nigra', 'E068 Brain Anterior Caudate', 'E069 Brain Cingulate Gyrus', 'E072 Brain Inferior Temporal Lobe', 'E067 Brain Angular Gyrus', 'E073 Brain_Dorsolateral_Prefrontal_Cortex'),multiple=TRUE)),
                        tabPanel('BREAST','BREAST',selectInput("b3", NULL,c( 'E027 Breast Myoepithelial Primary Cells'),multiple=TRUE)),
                        tabPanel('FAT','FAT',selectInput("b4", NULL,c( 'E063 Adipose Nuclei'),multiple=TRUE)),
                        tabPanel('GI_COLON','GI_COLON',selectInput("b5", NULL,c( 'E076 Colon Smooth Muscle', 'E106 Sigmoid Colon', 'E075 Colonic Mucosa'),multiple=TRUE)),
                        tabPanel('GI_DUODENUM','GI_DUODENUM',selectInput("b6", NULL,c( 'E078 Duodenum Smooth Muscle', 'E077 Duodenum Mucosa'),multiple=TRUE)),
                        tabPanel('GI_ESOPHAGUS','GI_ESOPHAGUS',selectInput("b7", NULL,c( 'E079 Esophagus'),multiple=TRUE)),
                        tabPanel('GI_INTESTINE','GI_INTESTINE',selectInput("b8", NULL,c( 'E109 Small Intestine'),multiple=TRUE)),
                        tabPanel('GI_RECTUM','GI_RECTUM',selectInput("b9", NULL,c( 'E103 Rectal Smooth Muscle', 'E101 Rectal Mucosa Donor 29', 'E102 Rectal Mucosa Donor 31'),multiple=TRUE)),
                        tabPanel('GI_STOMACH','GI_STOMACH',selectInput("b10", NULL,c( 'E111 Stomach Smooth Muscle', 'E110 Stomach Mucosa', 'E094 Gastric'),multiple=TRUE)),
                        tabPanel('HEART','HEART',selectInput("b11", NULL,c( 'E104 Right Atrium', 'E095 Left Ventricle', 'E105 Right Ventricle'),multiple=TRUE)),
                        tabPanel('LIVER','LIVER',selectInput("b12", NULL,c( 'E066 Liver'),multiple=TRUE)),
                        tabPanel('LUNG','LUNG',selectInput("b13", NULL,c( 'E096 Lung'),multiple=TRUE)),
                        tabPanel('MUSCLE','MUSCLE',selectInput("b14", NULL,c('E100 Psoas Muscle', 'E108 Skeletal Muscle Female', 'E107 Skeletal Muscle Male'),multiple=TRUE)),
                        tabPanel('OVARY','OVARY',selectInput("b15", NULL,c( 'E097 Ovary'),multiple=TRUE)),
                        tabPanel('PANCREAS','PANCREAS',selectInput("b16", NULL,c( 'E087 Pancreatic Islets', 'E098 Pancreas'),multiple=TRUE)),
                        tabPanel('SPLEEN','SPLEEN',selectInput("b17", NULL,c( 'E113 Spleen'),multiple=TRUE)),
                        tabPanel('THYMUS','THYMUS',selectInput("b18", NULL,c( 'E112 Thymus'),multiple=TRUE)),
                        tabPanel('VASCULAR','VASCULAR',selectInput("b19", NULL,c( 'E065 Aorta'),multiple=TRUE))
               ),
               tabPanel("Primary Fetal Tissue/Cell", 
                        tabPanel('ADRENAL','ADRENAL',selectInput("b20", NULL,c( 'E080 Fetal Adrenal Gland'),multiple=TRUE)),
                        tabPanel('BLOOD','BLOOD',selectInput("b21", NULL,c( 'E033 Primary T cells from cord blood', 'E031 Primary B cells from cord blood'),multiple=TRUE)),
                        tabPanel('BRAIN','BRAIN',selectInput("b22", NULL,c( 'E070 Brain Germinal Matrix', 'E082 Fetal Brain Female', 'E081 Fetal Brain Male'),multiple=TRUE)),
                        tabPanel('GI_INTESTINE','GI_INTESTINE',selectInput("b23", NULL,c( 'E085 Fetal Intestine Small', 'E084 Fetal Intestine Large'),multiple=TRUE)),
                        tabPanel('GI_STOMACH','GI_STOMACH',selectInput("b24", NULL,c( 'E092 Fetal Stomach'),multiple=TRUE)),
                        tabPanel('HEART','HEART',selectInput("b25", NULL,c( 'E083 Fetal Heart'),multiple=TRUE)),
                        tabPanel('KIDNEY','KIDNEY',selectInput("b26", NULL,c( 'E086 Fetal Kidney'),multiple=TRUE)),
                        tabPanel('LUNG','LUNG',selectInput("b27", NULL,c( 'E088 Fetal Lung'),multiple=TRUE)),
                        tabPanel('MUSCLE','MUSCLE',selectInput("b28", NULL,c( 'E089 Fetal Muscle Trunk', 'E090 Fetal Muscle Leg'),multiple=TRUE)),
                        tabPanel('PLACENTA','PLACENTA',selectInput("b29", NULL,c('E099 Placenta Amnion', 'E091 Placenta'),multiple=TRUE)),
                        tabPanel('THYMUS','THYMUS',selectInput("b30", NULL,c( 'E093 Fetal Thymus'),multiple=TRUE))
               ),
               tabPanel("Primary Culture", 
                        tabPanel('BLOOD','BLOOD',selectInput("b31", NULL,c( 'E116 GM12878 Lymphoblastoid Cells', 'E123 K562 Leukemia Cells'),multiple=TRUE)),
                        tabPanel('BONE','BONE',selectInput("b32", NULL,c( 'E129 Osteoblast Primary Cells'),multiple=TRUE)),
                        tabPanel('BRAIN','BRAIN',selectInput("b33", NULL,c( 'E054 Ganglion Eminence derived primary cultured neurospheres', 'E053 Cortex derived primary cultured neurospheres', 'E125 NH-A Astrocytes Primary Cells'),multiple=TRUE)),
                        tabPanel('BREAST','BREAST',selectInput("b34", NULL,c( 'E028 Breast variant Human Mammary Epithelial Cells (vHMEC)', 'E119 HMEC Mammary Epithelial Primary Cells'),multiple=TRUE)),
                        tabPanel('ESC','ESC',selectInput("b35", NULL,c( 'E002 ES-WA7 Cells', 'E008 H9 Cells', 'E001 ES-I3 Cells', 'E015 HUES6 Cells', 'E014 HUES48 Cells', 'E016 HUES64 Cells', 'E003 H1 Cells', 'E024 ES-UCSF4  Cells'),multiple=TRUE)),
                        tabPanel('ESC_DERIVED','ESC_DERIVED',selectInput("b36", NULL,c( 'E007 H1 Derived Neuronal Progenitor Cultured Cells', 'E009 H9 Derived Neuronal Progenitor Cultured Cells', 'E010 H9 Derived Neuron Cultured Cells', 'E013 hESC Derived CD56+ Mesoderm Cultured Cells', 'E012 hESC Derived CD56+ Ectoderm Cultured Cells', 'E011 hESC Derived CD184+ Endoderm Cultured Cells', 'E004 H1 BMP4 Derived Mesendoderm Cultured Cells', 'E005 H1 BMP4 Derived Trophoblast Cultured Cells', 'E006 H1 Derived Mesenchymal Stem Cells'),multiple=TRUE)),
                        tabPanel('FAT','FAT',selectInput("b37", NULL,c( 'E025 Adipose Derived Mesenchymal Stem Cell Cultured Cells', 'E023 Mesenchymal Stem Cell Derived Adipocyte Cultured Cells'),multiple=TRUE)),
                        tabPanel('IPSC','IPSC',selectInput("b38", NULL,c( 'E020 iPS-20b Cells', 'E019 iPS-18 Cells', 'E018 iPS-15b Cells', 'E021 iPS DF 6.9 Cells', 'E022 iPS DF 19.11 Cells'),multiple=TRUE)),
                        tabPanel('LUNG','LUNG',selectInput("b39", NULL,c( 'E128 NHLF Lung Fibroblast Primary Cells'),multiple=TRUE)),
                        tabPanel('MUSCLE','MUSCLE',selectInput("b40", NULL,c( 'E052 Muscle Satellite Cultured Cells', 'E120 HSMM Skeletal Muscle Myoblasts Cells', 'E121 HSMM cell derived Skeletal Muscle Myotubes Cells'),multiple=TRUE)),
                        tabPanel('SKIN','SKIN',selectInput("b41", NULL,c( 'E055 Foreskin Fibroblast Primary Cells skin01', 'E056 Foreskin Fibroblast Primary Cells skin02', 'E059 Foreskin Melanocyte Primary Cells skin01', 'E061 Foreskin Melanocyte Primary Cells skin03', 'E057 Foreskin Keratinocyte Primary Cells skin02', 'E058 Foreskin Keratinocyte Primary Cells skin03', 'E126 NHDF-Ad Adult Dermal Fibroblast Primary Cells', 'E127 NHEK-Epidermal Keratinocyte Primary Cells'),multiple=TRUE)),
                        tabPanel('STROMAL_CONNECTIVE','STROMAL_CONNECTIVE',selectInput("b42", NULL,c( 'E026 Bone Marrow Derived Cultured Mesenchymal Stem Cells', 'E049 Mesenchymal Stem Cell Derived Chondrocyte Cultured Cells'),multiple=TRUE)),
                        tabPanel('VASCULAR','VASCULAR',selectInput("b43", NULL,c( 'E122 HUVEC Umbilical Vein Endothelial Primary Cells'),multiple=TRUE))
               ),
               tabPanel("Cell Line", 
                        tabPanel('BLOOD','BLOOD',selectInput("b44", NULL,c( 'E115 Dnd41 TCell Leukemia Cell Line'),multiple=TRUE)),
                        tabPanel('CERVIX','CERVIX',selectInput("b45", NULL,c( 'E117 HeLa-S3 Cervical Carcinoma Cell Line'),multiple=TRUE)),
                        tabPanel('LIVER','LIVER',selectInput("b46", NULL,c( 'E118 HepG2 Hepatocellular Carcinoma Cell Line'),multiple=TRUE)),
                        tabPanel('LUNG','LUNG',selectInput("b47", NULL,c( 'E017 IMR90 fetal lung fibroblasts Cell Line', 'E114 A549 EtOH 0.02pct Lung Carcinoma Cell Line'),multiple=TRUE))
               )
               
        ))
   )),

  #panel for parameters
  wellPanel(
  fluidRow('Parameters:'),
  fluidRow(column(6,sliderInput(inputId='forecut',label='foreground cutoff (%)',min=0,max=100,value=80)),
  column(6,sliderInput(inputId='backcut',label='background cutoff (%)',min=0,max=100,value=20))),
  fluidRow(column(5,selectInput("state_number", 'ChromHMM state',c( '1_TssA','2_TssAFlnk', '3_TxFlnk', '4_Tx', '5_TxWk', '6_EnhG', '7_Enh', '8_ZNF/Rpts', '9_Het', '10_TssBiv', '11_BivFlnk'
, '12_EnhBiv', '13_ReprPC', '14_ReprPCWk', '15_Quies'),multiple=TRUE)
   )),
  #panel for submit and output
  fluidRow(column(3,offset=6,actionButton(inputId = 'submit',label='Submit')))),

  fluidRow(tableOutput('table'))
)

server<-function(input,output){

  #generate table
  table <-eventReactive(input$submit,{
   
    require(data.table)
    coord_state_file='test_table.txt'
    state_number=input$state_number
    fore_per=as.numeric(input$forecut)/100
    back_per=as.numeric(input$backcut)/100
    #parse the arguments
    fore_list=c()
    back_list=c()
    for(i in c(1:47))
    {
      #foreground
      tempf=eval(parse(text = paste('input$f',i,sep='')))
      if (length(tempf)>0)
      {
        fore_list=c(fore_list,tempf)
      }
      #background
      tempb=eval(parse(text = paste('input$b',i,sep='')))
      if (length(tempb)>0)
      {
        back_list=c(back_list,tempb)
      }
    }
    for (i in c(1:length(fore_list)))
    {
      fore_list[i]=substr(fore_list[i],1,4)
    }
    for (i in c(1:length(back_list)))
    {
      back_list[i]=substr(back_list[i],1,4)
    }
    cat('length of foreground samples:',length(fore_list),'\n','length of background samples:',length(back_list),'\n')
    cat('foreground list:',fore_list,'\n','background list:',back_list,'\n')
    
    
    #get data
    data_frame=fread(coord_state_file)
    
    #get column number
    name_list=names(data_frame)
    fore_column=match(fore_list,name_list)
    back_column=match(back_list,name_list)
    len_fore=length(fore_column)
    len_total=len_fore+length(back_column)
    fore_thres=length(fore_column)*fore_per
    back_thres=length(back_column)*back_per
    print(fore_column)
    print(back_column)
    
    #locate state_number in the table
    for (i in c(1:length(state_number)))
   {
     state_number[i]=unlist(strsplit(state_number[i],'_'))[1]
   }
    #
    if (length(state_number)==1)
    {
      data_logical=(data_frame[,c(fore_column,back_column),with=FALSE]==state_number[1])+0
    }else   
    {
      base='data_frame[,c(fore_column,back_column),with=FALSE]=='
      exp='data_frame[,c(fore_column,back_column),with=FALSE]==state_number[1]'
      for (x in state_number[c(2:length(state_number))])
      {
         exp=paste(exp,'|',base,x,sep='')
      }
      data_logical=eval(parse(text = exp))+0
    }
    #data_logical=(data_frame[,c(fore_column,back_column),with=FALSE]==state_number)+0
    print('done with locating state number in data')
    
    #get the rows satisfying the specificity requirement
    a=c(1:len_fore)
    b=c((len_fore+1):len_total)
    #design a function to evaluate specificit requirement and use apply function to apply the function to each row
    sum_subset <- function(x, c1, c2)  sum(x[c1])>=fore_thres & sum( x[c2])<=back_thres
    logic_list=apply(data_logical,1,sum_subset, c1=a,c2=b)
    print('done with finding rows satisfying specificity requirement')
    
    #get final data by combining coordinates and logical values
    cbind(data_frame[logic_list,c(1:3),with=FALSE],data_logical[logic_list,a])
    
    
  })

  #output table
  output$table <- renderTable({table()})
                                  
}

shinyApp(ui=ui,server=server)