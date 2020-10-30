#!/bin/bash

menuList() {
    clear
    echo -e "#####<-- Menu -->#####\n"
    echo "     1.One date"
    echo "     2.Two date"
    echo -e "     3.Exit\n"
    echo -e "# # # # # # # # # # # # # #\n"
}

userChoice() {
    read -p "Input based in your choice: --> " selectNum
    echo -e "\n"
}

getOneDate() {
    echo -e "Please input one date(like as YYYYMMDD): \n"
    read -n 8 date_n
    echo -e "\n"
}

getTwoDate() {
    echo -e "Please input first date(like as YYYYMMDD): \n"
    read -n 8 date_1

    echo -e "\n"

    echo -e "Please input second date(like as YYYYMMDD): \n"
    read -n 8 date_2

    echo -e "\n"
}

judgeWithOneDate() {
    getOneDate
    year=`expr ${date_n:0:4} + 0`
    month=`expr ${date_n:4:2} + 0`
    day=`expr ${date_n:6:2} + 0`
    moduleByFour=`expr ${date_n:0:4} % 4`
    moduleByHand=`expr ${date_n:0:4} % 100`
    moduleByFH=`expr ${date_n:0:4} % 400`
    if [ $moduleByFour -eq 0 -a $moduleByHand -ne 0 -o $moduleByFH -eq 0 ];then
        echo -e "${year} --> this is leap year.\n"
    else
        echo -e " ${year} --> this isn't leap year.\n"
        echo "${leapYearFlag}"
    fi
}

judgeWeek() {
    if [ ${month} -eq 1 ]
    then month=13
    echo "--> ${month}"
    elif [ ${month} -eq 2 ]
    then month=14
    echo "--> ${month}"
    fi
    temp1=`expr 2 \* ${month}`
    month=`expr ${month} + 1`
    temp2=`expr 3 \* ${month} / 5`
    temp3=`expr ${year} / 4`
    temp4=`expr ${year} / 100`
    temp5=`expr ${year} / 400`
    temp6=`expr ${day} + ${temp1} + ${temp2} + ${year} + ${temp3} - ${temp4} + ${temp5}`
    result=`expr ${temp6} % 7`
    case ${result} in
        0)  echo -e "Monday\n"
        ;;
        1)  echo -e "Tuesday\n"
        ;;
        2)  echo -e "Wednesday\n"
        ;;
        3)  echo -e "Thursday\n"
        ;;
        4)  echo -e "Friday\n"
        ;;
        5)  echo -e "Saturday\n"
        ;;
        6)  echo -e "Sunday\n"
        ;;
        *)  break
        ;;
    esac
    echo -e "Please input 'R' back to meau.\n"
    read -n 1 temp
}

judgeWithTwoDate() {
    leapYear_array=(31 29 31 30 31 30 31 31 30 31 30 31)
    NormalYear_array=(31 28 31 30 31 30 31 31 30 31 30 31)
    getTwoDate
    year_1=`expr ${date_1:0:4} + 0`
    month_1=`expr ${date_1:4:2} + 0`
    day_1=`expr ${date_1:6:2} + 0`

    year_2=`expr ${date_2:0:4} + 0`
    month_2=`expr ${date_2:4:2} + 0`
    day_2=`expr ${date_2:6:2} + 0`

    if [ ${year_1} -gt ${year_2} ]
    then temp_year=${year_1}
        year_1=${year_2}
        year_2=${temp_year}
        temp_month=${month_1}
        month_1=${month_2}
        month_2=${temp_month}
        temp_day=${day_1}
        day_1=${day_2}
        day_2=${temp_day}
    fi

    echo -e "${year_1}\n"
    echo -e "${year_2}\n"

    sum1=0
    sum2=0

    leap_year_1=0
    leap_year_2=0

    moduleByFour_1=`expr ${year_1} % 4`
    moduleByHand_1=`expr ${year_1} % 100`
    moduleByFH_1=`expr ${year_1} % 400`
    if [ $moduleByFour_1 -eq 0 -a $moduleByHand_1 -ne 0 -o $moduleByFH_1 -eq 0 ];
    then let leap_year_1+=1
    fi

    moduleByFour_2=`expr ${year_2} % 4`
    moduleByHand_2=`expr ${year_2} % 100`
    moduleByFH_2=`expr ${year_2} % 400`
    if [ $moduleByFour_2 -eq 0 -a $moduleByHand_2 -ne 0 -o $moduleByFH_2 -eq 0 ];
    then let leap_year_2+=1
    fi

    for((i=0;i<${month_1};i++));
    do
        if [ ${leap_year_1} -eq 1 ];then
            let sum1+=leapYear_array[i]
        else
            let sum1+=NormalYear_array[i]
        fi
    done
    let sum1+=day_1

    for((i=0;i<${month_2};i++));
    do
        if [ ${leap_year_2} -eq 1 ];then
            let sum2+=leapYear_array[i]
        else
            let sum2+=NormalYear_array[i]
        fi
    done
    let sum2+=day_2

    for((i=${year_1};i<${year_2};i++));
    do
        temp_year_m4=0
        let temp_year_m4=i%4
        temp_year_m100=0
        let temp_year_m100=i%100
        temp_year_m400=0
        let temp_year_m400=i%400
        if [ ${temp_year_m4} -eq 0 -a ${temp_year_m100} -ne 0 -o ${temp_year_m400} -eq 0 ];then
        let sum2+=366
        else
            let sum2+=365
        fi
    done

    result_diffDay=0
    let result_diffDay=sum2-sum1

    echo -e "Diffresult is ${result_diffDay}\n"

    # echo "${leap_year_1}"
    # echo "${leap_year_2}"
    echo ${sum1}
    echo ${sum2}

    echo -e "Please input 'R' back to meau.\n"
    read -n 1 temp
}




flag=1

while [ ${flag} -eq 1 ]
do
    menuList
    userChoice
    case ${selectNum} in 
        1)  judgeWithOneDate
            judgeWeek
        ;;
        2)  judgeWithTwoDate
        ;;
        3)  flag=0
            echo -e "See you again. :) \n"
        ;;
        *)  break
        ;;
    esac
done



# judgeWithOneDate

# judgeWeek



