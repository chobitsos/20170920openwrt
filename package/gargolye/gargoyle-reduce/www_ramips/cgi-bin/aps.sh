#!/usr/bin/haserl
<%
eval $( gargoyle_session_validator -c "$COOKIE_hash" -e "$COOKIE_exp" -a "$HTTP_USER_AGENT" -i "$REMOTE_ADDR" -r "/login1.asp" -t $(uci get gargoyle.global.session_timeout) -b "$COOKIE_browser_time"  )
echo "Content-Type: application/json"
echo ""
i=0
#echo "HTTP/1.1 200 OK"
echo "{"
iwpriv ra0 set SiteSurvey=0
sleep 2
iwpriv ra0 get_site_survey | grep '^[0-9]' | while read line
#/www/cgi-bin/scan 
#cat /tmp/ssids | while read line
do
	chanel=`echo $line | awk '{print $1}'`
	#if ${line:5:1} == ' ' 
	if [ "${line:5:1}" = " " ]; then 
		ssid="[unknown]"
		bssid=`echo $line | awk '{print $2}'`
		security=`echo $line | awk '{print $3}'`
		signal=`echo $line | awk '{print $4}'`
		wmode=`echo $line | awk '{print $5}'`
		extch=`echo $line | awk '{print $6}'`
		nt=`echo $line | awk '{print $7}'`
		wps=`echo $line | awk '{print $8}'`
	else
		ssid=`echo $line | awk '{print $2}'`
		bssid=`echo $line | awk '{print $3}'`
		security=`echo $line | awk '{print $4}'`
		signal=`echo $line | awk '{print $5}'`
		wmode=`echo $line | awk '{print $6}'`
		extch=`echo $line | awk '{print $7}'`
		nt=`echo $line | awk '{print $8}'`
		wps=`echo $line | awk '{print $9}'`
	fi

	if [ $i -ne 0 ]; then
	echo ","
	fi

	let i+=1
	echo "\"$ssid\":{"
	echo "\"chanel\":"$chanel","
	#echo "\"ssid\":\""$ssid"\","
	echo "\"bssid\":\""$bssid"\","
	echo "\"security\":\""$security"\","
	echo "\"signal\":\""$signal"\","
	echo "\"wmode\":\""$wmode"\","
	echo "\"extch\":\""$extch"\","
	echo "\"nt\":\""$nt"\","
	echo "\"wps\":\""$wps"\""
	echo -n "}"
done
echo "}"
%>
