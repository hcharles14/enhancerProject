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