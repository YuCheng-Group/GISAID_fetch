#!/usr/bin/perl -w

$sid_rq	= "7E40AEAGW99VCVRJRQZUABFK9MNO64UZ";

#$id = "406030";
$id = $ARGV[0];

$result = `curl 'https://platform.gisaid.org/epi3/start/EPI_ISL/${id}' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:71.0) Gecko/20100101 Firefox/71.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Connection: keep-alive' -H 'Cookie: sid=${sid_rq}' -H 'Upgrade-Insecure-Requests: 1'`;

#print $result;

	if ($result =~ /sid\" value=\'(.*?)\'/){	${sid} = $1;}
	if ($result =~ /wid\" value=\'(.*?)\'/){	${wid} = $1;}
	if ($result =~ /pid\" value=\'(.*?)\'/){	${pid} = $1;}
	if ($result =~ /ts\" value=\'(.*?)\'/){	${ts} = $1;}

	print	$sid."\n";
	print	$wid."\n";
	print	$pid."\n";
	print	$ts."\n";

	$ts =~ s/ /+/g;
	print	$ts."\n";
	$ts =~ s/:/%3A/g;
	print	$ts."\n";


$result_1 = `curl 'https://platform.gisaid.org/epi3/frontend' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:71.0) Gecko/20100101 Firefox/71.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Content-Type: application/x-www-form-urlencoded' -H 'Origin: https://platform.gisaid.org' -H 'Connection: keep-alive' -H 'Referer: https://platform.gisaid.org/epi3/start/EPI_ISL/404227' -H 'Cookie: sid=${sid_rq}' -H 'Upgrade-Insecure-Requests: 1' --data 'sid=${sid}&wid=${wid}&pid=${pid}&ts=${ts}&ua_info=%7B%22java_enabled%22%3Afalse%2C%22user_agent%22%3A%22Mozilla%2F5.0+%28Macintosh%3B+Intel+Mac+OS+X+10.14%3B+rv%3A71.0%29+Gecko%2F20100101+Firefox%2F71.0%22%2C%22language%22%3A%22en-US%22%2C%22screen%22%3A%221920x1080%22%7D&mode=page'`;

#print $result_1;

	$wid_2 = $wid;
	if ($result_1 =~ /sys.goPage\(\'(pid_.*?)\'\)/){
		$pid_2 = $1;
	}else {
		print	"EXIT!!!\n";
		exit();
	}

$pid = $pid_2;
$wid = $wid_2;

$ts = time();

$result_2 = `curl 'https://platform.gisaid.org/epi3/frontend' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:71.0) Gecko/20100101 Firefox/71.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Content-Type: application/x-www-form-urlencoded' -H 'Origin: https://platform.gisaid.org' -H 'Connection: keep-alive' -H 'Referer: https://platform.gisaid.org/epi3/frontend' -H 'Cookie: sid=${sid}' -H 'Upgrade-Insecure-Requests: 1' --data 'sid=${sid}&wid=${wid}&pid=${pid}&ts=${ts}&mode=page'`;

#print $result_2;
	
	$wid_3	= $wid;
	if ($result_2 =~ /sys.openOverlay\(\'(wid_.*?)\','(pid_.*?)\'/){
		$pid_3 = $2;
	}else {
		print	"EXIT!!!\n";
		exit();
	}

$pid = $pid_3;
$ts = time();

$result_3 = `curl 'https://platform.gisaid.org/epi3/frontend' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:71.0) Gecko/20100101 Firefox/71.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Content-Type: application/x-www-form-urlencoded' -H 'Origin: https://platform.gisaid.org' -H 'Connection: keep-alive' -H 'Cookie: sid=${sid}' -H 'Upgrade-Insecure-Requests: 1' --data 'sid=${sid}&wid=${wid}&pid=${pid}&ts=${ts}&mode=page'`;

#print $result_3;

	if ($result_3 =~ /WID\"\] = \"(wid_.*?)\";/){
		$wid_4 = $1;
	}
	if ($result_3 =~ /PID\"\] = \"(pid_.*?)\";/){
		$pid_4 = $1;
	}

$pid = $pid_4;
$wid = $wid_4;
$ts = time();

$result_4 = `curl 'https://platform.gisaid.org/epi3/frontend' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:71.0) Gecko/20100101 Firefox/71.0' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' -H 'X-Requested-With: XMLHttpRequest' -H 'Origin: https://platform.gisaid.org' -H 'Connection: keep-alive' -H 'Referer: https://platform.gisaid.org/epi3/frontend' -H 'Cookie: sid=${sid}' --data 'sid=${sid}&wid=${wid}&pid=${pid}&data=%7B%22queue%22%3A%5B%7B%22wid%22%3A%22${wid}%22%2C%22pid%22%3A%22${pid}%22%2C%22cid%22%3A%22c_q7elyq_xu%22%2C%22cmd%22%3A%22SetScrollPosition%22%2C%22params%22%3A%7B%22top%22%3A5013%2C%22left%22%3A0%7D%2C%22equiv%22%3Anull%7D%2C%7B%22wid%22%3A%22${wid}%22%2C%22pid%22%3A%22${pid}%22%2C%22cid%22%3A%22c_q7elyq_xy%22%2C%22cmd%22%3A%22Download%22%2C%22params%22%3A%7B%7D%2C%22equiv%22%3Anull%7D%5D%7D&ts=${ts}&mode=ajax'`;

print $result_4;


	if ($result_4 =~ /sys.downloadFile\(\\\"(.*?)\\/){
		$path = $1;
	}
print $path;

	print "https://platform.gisaid.org$path";

	`wget https://platform.gisaid.org$path`;

