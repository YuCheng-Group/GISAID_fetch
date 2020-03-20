# GISAID: fetch the fasta files of COVID-19 automatically
Fetch the fasta files automatically.

* required data
1. session_id
2. ID list


step 1.

modify the `sid_rq` with the new session_id in the `fetch.pl` file

step 2.

execute the following command

```
cat list.txt | xargs -I{} sh -c "perl fetch.pl {}"
```
