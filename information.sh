#!/bin/bash


    #Flags
    kFlag=
    pFlag=
    uFlag=
    gFlag=
    lFlag=
    vFlag=
    aFlag=
    dFlag=
    dArgument=


    while getopts kpuglvad: opt
    do
        case "$opt" in
            k) 
                kFlag=1;;
            p)
                pFlag=1;;
            u) 
                uFlag=1;;
            g) 
                gFlag=1;;
            l) 
                lFlag=1;;
            v) 
                vFlag=1;;
            a) 
                aFlag=1;;
            d) 
                dFlag=1
                dArgument=$OPTARG
                ;;
            \?)
                echo "usage: $0 [-kpuglva] [-d directory]"
                exit 1;;
        esac
    done

    function kflag {
      uname -srv
    }


    function pflag {
      ps -a | wc -l
    }

    function uflag {
      awk -F: '{print "Username:" $1, "\nUserID:" $3, "\nGroupID:" $4, "\nHome:" $6, "\nShell:" $7."\n"}' /etc/passwd
    }

    function gflag {
      users=$(awk -F: '{ print $1}' /etc/passwd)
       for user in $users;do
         echo Username: $user
         echo Groups: `id $user -nG | awk '{n=split($0, a);for(i in a) if (i<n){ print a[i]","} else {print a[i]} }'`
         echo  
       done
    }
  
    function lflag {
      find $HOME -printf "%s %f\n"| sort -nr| head -10 
    }

    function dflag {
        ls -a $dArgument | wc -l
    }

    function vflag {
      usrname=`awk -F: '{print $1}' /etc/passwd | head -1`
      home=`awk -F: '{print $6}' /etc/passwd | head -1`
      shell=`awk -F: '{print $7}' /etc/passwd | head -1`
      path=`echo $PATH`
      echo Username: $usrname
      echo Home:     $home
      echo Shell:    $shell
      echo Path:     $path
    }

    function aflag {
      kflag
      pflag
      uflag
      gflag
      lflag
      vflag
      dflag
    }


    #kFlag
    if [ -n "$kFlag" ]; then
      kflag
    fi

    #pFlag
    if [ -n "$pFlag" ]; then
      pflag
    fi

    #uFlag
    if [ -n "$uFlag" ]; then
      uflag
    fi
    
    #gFlag
    if [ -n "$gFlag" ]; then
      gflag       
    fi

    #lFlag
    if [ -n "$lFlag" ]; then
      lflag
    fi

    #dFlag
    if [ -n "$dFlag" ];then 
      dflag
    fi

    #vFlag
    if [ -n "$vFlag" ];then
      vflag
    fi

    if [ -n "$aFlag" ];then
      aflag
    fi
   
