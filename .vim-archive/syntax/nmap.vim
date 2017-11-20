
" Creator: Pento <naplanetu[at]gmail.com>
" Maintainer: Knightmare <knightmare2600[at]googlemail.com>
" Maintainer: lx
" Version: 2013_007

"------------------------------------------------------------------------
" This vim file will syntax highlight your nmap output when piped	-
" to a file.  Best put it in ~/.vim/syntax/nmap.vim and then call	-
" it with :set syntax=nmap in vim.					-
"									-
" Version History:							-
"									-
" 10 Nov 2009	Pento		Inital Version				-
" 26 Jan 2013	Knightmare	Started rewrite: added protocols	-
" 27 Jan 2013	Knightmare	Update to highlight times/dates		-
" 27 Jan 2013	Knightmare	Update to do MAC Addresses too		-
" 28 Jan 2013	Knightmare	Add <-- comment and - in protocol names	-
" 28 Jan 2013	Knightmare	Add proper colours when highlighting    -
" 28 Jan 2013	Knightmare	More colours and missing protocols	-
" 28 Jan 2013	Knightmare	Dark Red Errors/Warnings to stand out	-
" 28 Jan 2013	Knightmare	Mark OS guess and NSE output too	-
"------------------------------------------------------------------------

" TODO: Add script output highlighting, which is multi line
" TODO: Split up protocols so they are on 26 lines to make life easier

if version < 600 
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" Nmap is fond of using hyphens in protocol names, e.g. netbios-ssn so match that too
setlocal iskeyword+=-

syntax sync fromstart

" Highlight NMap banners
syn region nmapBanner start="^Starting Nmap" end="at"
syn region nmapNSE start="^NSE" end=".*"
syn region nmapReport start="^Nmap scan report" end="for"
syn keyword nmapStatement PORT STATE SERVICE VERSION TRACEROUTE ADDRESS HOP RTT 
syn match nmapComment "#.*$"

" Port numbers and Status
syn match nmapPort "^\d\+/"
syn keyword nmapPortStatus  open closed filtered unfiltered
"syn region nmapScriptOutput start="^\|" end="^|_.*"

" Dates and times and the adjectives they use
syn keyword nmapTimePeriod hour hours minute minutes second seconds day days GMT DST UTC BST Mon Tue Wed Thu Fri Sat Sun latency
syn match nmapDate "[0-9][0-9][0-9][0-9]\-[.0-9_]*\-[0-9][0-9]"
syn match nmapTime "([0-1]?[0-9]|2[0-4]):([0-5][0-9])(:[0-5][0-9])?$"
"syn match nmapScanTime "[0-2][0-9]\:[0-5][0-9]"

" Hightlight OS, OS version, CPE and Service info lines
syn region nmapOSDetails start='^OS details:' end='.*'
syn region nmapOSRunning start='^Running' end='.*'
syn region nmapOSRunning start="^Aggressive OS" end="guesses:"
syn region nmapOSCPE start='^OS CPE:' end='.*'
syn region nmapServiceInfo start='Service Info:' end='.*'

" IPs, Hostnames, MACs, TCP sequence and device types
syn match nmapIP "\d\+\.\d\+\.\d\+\.\d\+"
syn match nmapHostName "[a-zA-Z0-9._-]\+\.[a-zA-Z]\{2,3}"
syn match nmapMACAddress "/^([0-9a-f]{1,2}[\.:-]){5}([0-9a-f]{1,2})$/i"
syn keyword nmapTCPPrediction Trivial joke Easy Medium Formidable Worthy challenge Good luck!
syn region nmapDeviceTypeLine start="^Device type" end="\s"
syn keyword nmapDeviceType general purpose bridge broadband router firewall game console hub load balancer media device PBX PDA phne power-device printer print server proxy server remote management router security-misc specialized storage-misc switch telecom-misc terminal terminal server VoIP adapter VoIP phone WAP webcam

" Highlight URLs working on the premise URLs don't include spaces
syn region nmapURL start="http://" end=" "

" Warnings and errors
syn region nmapErrorWarning start="Warning:" end=".*"
syn region nmapErrorWarning start="Too many fingerprints match this host to give specific OS" end="details"
syn region nmapErrorWarning start="^[0-65535] services unrecognized" end=".*"

syn keyword nmapProto 3com-tsmux 3ds-lm 3l-l1 3m-image-lm 914c-g 9pfs BackOrifice CarbonCopy DragonIDSConsole Elite H.323/Q.931 IIS IISrpc-or-vat L2TP LSA-or-nterm NFS-or-IIS RETS-or-BackupExec Trinoo_Bcast Trinoo_Master Trinoo_Register X11 X11:1 X11:2 X11:3 X11:4 X11:5 X11:59 X11:6 X11:7 X11:8 X11:9 aal-lm abbaccuray about abyss acap acas accessbuilder aci acmaint_dbd acmaint_transd acmsoda acp acr-nema activesync activesync-notify adapt-sna admd admdog admeng advocentkvm aed-512 aeroflight-ads af afp afs afs3-bos afs3-callback afs3-errors afs3-fileserver afs3-kaserver afs3-prserver afs3-rmtsys afs3-update afs3-vlserver afs3-volser airport-admin airs ajp12 ajp13 alpes alta-ana-lm amanda amandaidx amidxtape ampr-info ampr-inter ampr-rcmd amqp analogx anet ansanotify ansatrader ansoft-lm-1 ansoft-lm-2 ansyslmd anynetgateway aol aol-1 aol-2 aol-3 apc-agent apertus-ldp apple-imap-admin apple-iphoto apple-licman apple-xsrvr-admin appleqtc appleqtcsrvr applix apri-lm arcisdms arcserve ariel1 ariel2 ariel3 arns as-servermap asa asa-appl-proto asap-sctp asap-sctp-tls asap-tcp asf-rmcp asip-webadmin aspeclmd aspentec-lm at-3 at-5 at-7 at-8 at-echo at-nbp at-rtmp at-zis atex_elmd atls atm-zip-office ats audio-activmail audionews audit auditd aurora aurora-cmgr aurp auth autodesk-lm avian axon-lm backupexec bakbonenetvault banyan-rpc banyan-vip bbn-mmc bbn-mmx bdp bftp bgmp bgp bgpd bh611 bhevent bhfhs bhmds biff bigbrother biimenu bittorrent-tracker bl-idm blackboard blackice-alerts blackice-icecap blackjack blueberry-lm bmap bnet bo2k boinc bootclient bootserver btx busboy bwnfs bytex cab-protocol cableport-ax cacp cadis-1 cadis-2 cadkey-licman cadkey-tablet cadlock cadsi-lm cal canna car carracho cce3x cce4x ccmail ccproxy-ftp ccproxy-http cdc cdfunc cfdptkt cfengine cfs chargen checksum chromagrafx chshell cichild-lm cichlid cisco-fna cisco-ipsla cisco-sccp cisco-sys cisco-tna ciscopop citadel citrix-ica cl-1 clearcase cloanto-net-1 clvm-cfg cmip-man coauthor codaauth2 codasrv codasrv-se cognex-insight coldfusion-auth commerce commplex-link compaqdiag compressnet comscm con concert conf conference confluent connect-proxy connlcli contentserver controlit corba-iiop corbaloc courier covia creativepartnr creativeserver cronus crs crystalenterprise crystalreports csdm csdmbase csi-sgwp cslistener csnet-ns ctf cucme-1 cucme-2 cucme-3 cucme-4 cuillamartin custix cvc cvc_hostd cvspserver cxtp cybercash cycleserv cycleserv2 cypress dasp datasurfsrv datasurfsrvsec datex-asn dayna daytime dbase dbbrowse dberegister dbreporter dbsa-lm dbstar dc dca dcp dcs ddm-dfm ddm-rdb ddm-ssl ddt dec-notes decap decauth decbsrv decladebug dectalk decvms-sysmgt deos deslogin deslogind device device2 deviceshare dhcpc dhcps dhcpv6-client dhcpv6-server diagmond diameter dict digital-vrc direct dis discard distccd dixie dlip dls dls-mon dls-monitor dlsrpn dlswpn dmdocbroker dn6-nlm-aud dn6-smm-red dna-cml dnet-keyproxy dnet-tstproxy dnsix docstor domain doom down dpsi dsETOS dsf dsfgw dsp dsp3270 dtag-ste-sb dtk dtspc dvl-activemail dvs dwf echo editbench edonkey eicon-server eicon-slp eicon-x25 eims-admin eklogin ekshell elan elcsd ellpack embl-ndt emce emfis-cntl emfis-data enrp-sctp enrp-sctp-tls entomb entrustmanager entrusttime equationbuilder erpc esl-lm esro-gen essbase eudora-set evb-elm exec extensisportfolio eyelink fasttrack fatserv fax fc-cli fc-ser fcp fhc filemaker finger firewall1-rdp fj-hdnet flexlm flexlm0 flexlm1 flexlm10 flexlm2 flexlm3 flexlm5 flexlm7 flexlm9 fln-spx fodms font-service fpo-fns freeciv ftp ftp-agent ftp-data ftp-proxy ftps ftps-data ftsrv fujitsu-dev fujitsu-dtc fujitsu-dtcns funkproxy fw1-mc-fwmodule fw1-mc-gui fw1-or-bgmp fw1-secureremote gacp gandalf-lm garcon gdomap gdp-port genie genie-lm genrad-mux ginad git gkrellm globalcatLDAP globalcatLDAPssl globe glogger gnutella gnutella2 go-login goldleaf-licman gopher gppitnp graphics gridgen-elmd gss-http gss-xlicen gtegsc-lm gv-us gwha h225gatedisc h248-binary h323gatestat hacl-cfg hacl-gs hacl-hb hacl-local hacl-probe hacl-test halflife hassle hdap hddtemp hecmtl-db hems here-lm heretic2 hermes hexen2 hiq hostname hosts2-ns hotline hp-3000-telnet hp-alarm-mgr hp-collector hp-hcip hp-managed-node hpnpd http http-alt http-mgmt http-proxy http-rpc-epmap https https-alt hybrid hybrid-pop hydap hylafax hyper-g iad1 iad2 iad3 iafdbase iafserver iasd ibm-app ibm-cics ibm-db2 ibm-db2-admin ibm-mqseries ibm-pps ibm-res ibm_wrless_lan icad-el icb iclpv-dm iclpv-nlc iclpv-nls iclpv-pm iclpv-sas iclpv-sc iclpv-wsm icq ida-agent idfp ies-lm ifor-protocol igi-lm iiimsf iiop imap imap3 imap4-ssl imaps imsldoc imsp imtc-mcs infoman informatik-lm infoseek ingres-net ingreslock innosys innosys-acl insitu-conf instl_bootc instl_boots intecourier integra-sme intellistor-lm interbase interhdl_elmd intrinsa intuitive-edge invokator ipcd ipcserver ipdd ipfix ipfixs iphone-sync ipp ipx irc ircs is99c is99s isakmp iscsi isdninfo isi-gl isis isis-bcast iso-ill iso-ip iso-tp0 iso-tsap iso-tsap-c2 isode-dua isqlplus iss-console-mgr iss-realsec iss-realsecure issa issc issd itu-bicc-stc iua ivs-video ivsd java-or-OTGfileshare jetdirect kademlia kauth kdm kerberos kerberos-adm kerberos-sec kerberos_master keyserver kip kis klogin knet-cmp knetd kpasswd kpasswd5 kpop krb524 krb_prop krbupdate kryptolan kshell kuang2 kx la-maint lam landesk-cba landesk-rc lanserver lansource laplink ldap ldapssl ldp legent-1 legent-2 lgtomapper liberty-lm licensedaemon link linuxconf linx listen ljk-login loadsrv localinfosrvr lockd locus-con locus-map login lonewolf-lm lotusnotes lsnr lupa m2pa m2ua m3ua mac-srvr-admin macon magenta-logic mailbox mailbox-lm mailq maitrd man mapper-mapethd mapper-nodemgr mapper-ws_ethd marcam-lm matip-type-a matip-type-b maybe-fw1 maybe-veritas mciautoreg mcidas mdbs_daemon meetingmaker megaco-h248 meta-corp metagram meter mfcobol mftp mgcp-gateway micom-pfs micromuse-lm microsoft-ds mimer miroconnect mit-dov mit-ml-dev miteksys-lm mlchat-proxy mloadd mm-admin mmcc mnotes mobileip-agent mobilip-mn molly mondex monitor montage-lm mortgageware mosmig mount mpm mpm-flags mpm-snd mpp mps-raft mptn ms-lsa ms-olap4 ms-rome ms-shuttle ms-sna-base ms-sna-server ms-sql-m ms-sql-s ms-sql2000 ms-term-serv ms-wbt-server msantipiracy msdtc msg-auth msg-icp msgsys msl_lmd msmq msnp msp msql msrpc multidropper multiplex mumps mupdate mvx-lm mylex-mapd mysql mythtv nameserver namp napster nat-t-ike ncd-conf ncd-diag ncd-diag-tcp ncd-pref ncd-pref-tcp nced ncld ncp ncube-lm ndm-requester ndm-server ndsauth nerv nessus nest-protocol netassistant netbackup netbios-dgm netbios-ns netbios-ssn netbus netcheque netcp netgw netinfo netlabs-lm netmap_lm netnews netop-rc netrcs netrjs-1 netrjs-2 netrjs-3 netrjs-4 netsaint netsc-dev netsc-prod netstat netvenuechat netview-aix-1 netview-aix-10 netview-aix-11 netview-aix-12 netview-aix-2 netview-aix-3 netview-aix-4 netview-aix-5 netview-aix-6 netview-aix-7 netview-aix-8 netview-aix-9 netviewdm1 netviewdm2 netviewdm3 netwall netware-csp netware-ip new-rwho newacct news nextstep nfa nfs nfsd-keepalive nfsd-status nfsrdma ni-ftp ni-mail nim nimreg nip nkd nlogin nms nms_topo_serv nmsp nnsp nntp notify novastorbakcup novell-lu6.2 npmp-gui npmp-local npmp-trap npp nqs nrcabq-lm nrpe ns nsiiops nsrexecd nss-routing nsw-fe ntalk ntp nucleus nuts_bootp nuts_dem objcall objective-dbc objectmanager oc-lm ocbinder oceansoft-lm ock ocs_amu ocs_cmu ocserver odmr oftep-rpc ohimsrv omad omfs omid omserv onmux opalis-rdv opalis-robot opc-job-start opc-job-track openmanage openmath openport openvms-sysipc opsec-cvp opsec-ela opsec-lea opsec-sam opsec-ufp optima-vnet ora-lm oracle orasrv os-licman ospfd osu-nms osxwebadmin overnet pacerforum padl2sim paradym-31 park-agent passgo password-chg pawserv pcanywhere pcanywheredata pcanywherestat pcduo pcduo-old pciarray pcm pcmail-srv pcnfs pdap pdap-np pds peerenabler pegboard pehelp peport perf-port personal-link ph pharos philips-vc phonebook photuris pim-port pim-rp-disc pip pipe_server pipes pirp pksd polestar polipo pop2 pop3 pop3pw pop3s postgresql pov-ray powerburst powerchute powerchuteplus ppp pptp print-srv printer priv-dial priv-file priv-mail priv-print priv-rje priv-term priv-term-l privoxy prm-nm prm-nm-np prm-sm prm-sm-np profile proshare1 proshare2 proshareaudio prosharedata prosharenotify prosharerequest prosharevideo prospero proxima-lm proxy-plus prsvp ptcnameservice puparp pwdgen pythonds qaz qbikgdp qft qmqp qotd qrh qsc quake quake2 quake3 quakeworld quicktime quotad radacct radius radmin radmind raid-ac raid-am raid-cc raid-cd raid-cs raid-sf rap rap-listen rap-service rcip-itu rcp rds rds2 re-mail-ck reachout realserver relief rellpack remote-kis remoteanything remotefs rendezvous resvc retrospect rfa rfe rfx-lm rgtp ricardo-lm rightbrain rimsl ripd ripng ris ris-cm rje rkinit rlp rmonitor rmonitor_secure rmt rna-lm rndc robcad-lm route rpasswd rpc2portmap rpcbind rplay rrh rsftp rsh-spx rsvd rsvp_tunnel rsync rtelnet rtip rtmp rtsclient rtsp rtsserv rwhois rww rxe rxmon s-net sae-urn saft samba-swat sapcomm sapeps saposs saprouter sas-1 sas-2 sas-3 sbook scc-security sco-dtmgr sco-websrvrmg3 scohelp scoi2odialog scoremgr scrabble screencast sctp-tunneling scx-proxy sd sdadmind sdfunc sdlog sdnskmp sdsc-lm sdserv sdxauthd search secure-aux-bus secureidprop securenetpro-sensor securid semantix send seosload serialnumberd servexec servserv set sfs-config sfs-smp-net sftp sgcp sgi-dgl sgmp sgmp-traps shadowserver shell shiva_confsrvr shivadiscovery shivahose shivasound shrinkwrap siam sieve sift-uft silc silverplatter simba-cs simco sip sip-tls sj3 skkserv skronk slnp smakynet smartsdp smip-agent smpte sms-rcinfo sms-xfer smsd smsp smtp smtps smux snagas snare snet-sensor-mgmt snews snmp snmp-tcp-port snmptrap snpp sns_credit sntp-heartbeat socks softcm softpc sometimes-rpc1 sometimes-rpc10 sometimes-rpc11 sometimes-rpc12 sometimes-rpc13 sometimes-rpc14 sometimes-rpc15 sometimes-rpc16 sometimes-rpc17 sometimes-rpc18 sometimes-rpc19 sometimes-rpc2 sometimes-rpc20 sometimes-rpc21 sometimes-rpc22 sometimes-rpc23 sometimes-rpc24 sometimes-rpc25 sometimes-rpc26 sometimes-rpc27 sometimes-rpc28 sometimes-rpc3 sometimes-rpc4 sometimes-rpc5 sometimes-rpc6 sometimes-rpc7 sometimes-rpc8 sometimes-rpc9 sonar sophia-lm sophos spamassassin spc spsc sql-net sqlnet sqlserv sqlsrv squid-htcp squid-http squid-ipc squid-snmp src srmp srssend ss7ns ssh ssserver sstats statsci1-lm statsci2-lm statsrv stel stmf stone-design-1 stun-p1 stun-p2 stun-p3 stun-port stx su-mit-tg sua submission submit submitserver subntbcst_tftp subseven sun-answerbook sun-manageconsole supdup supfiledbg supfilesrv support sur-meas svn svrloc swift-rvf sybase sygatefw symantec-av symplex synoptics-trap synotics-broker synotics-relay syslog systat tabula tacacs tacacs-ds tacnews taligent-lm talk tam tcp-id-port tcpmux tcpnethaspsrv teedtap telefinder telelpathattack telelpathstart telesis-licman telnet telnets tempo tenebris_nts teradataordbms terminaldb tftp ticf-1 ticf-2 timbuktu timbuktu-srv1 timbuktu-srv2 timbuktu-srv3 timbuktu-srv4 time timed timeflies tinyfw tlisrv tn-tl-fd1 tn-tl-w2 tnETOS tns-cml tor-control tor-orport tor-socks tor-trans tpdu tpip tr-rsrb-p1 tr-rsrb-p2 tr-rsrb-p3 tr-rsrb-port troff tserver ttyinfo uaac uaiact uarps udt_os ufsd uis ulistserv ulp ulpnet umeter unicall unidata-ldm unify unitary unknown upnp ups ups-onlinet urm us-gv utcd utime utmpcd utmpsd uucp uucp-path uucp-rlogin v5ua valisys-lm vat vat-control vemmi venus venus-se veracity veritas-ucl vettcp via-ftp vid video-activmail videotex virtual-places vistium-share vlsi-lm vmnet vmodem vmpwscs vnas vnc vnc-1 vnc-2 vnc-3 vnc-http vnc-http-1 vnc-http-2 vnc-http-3 vpac vpad vpvc vpvd vsinet vslmp wap-push wap-wsp waste watcom-sql watershed-lm wdbrpc webster who whoami whois whosockami win-rpc wincim windows-icfw wins wizard wmedistribution wmereceiving wmereporting wms wnn6 wnn6_DS work-sol world-lm wpages wpgs www-dev x25-svc-port xaudio xdmcp xdsxdm xfer xinuexpansion1 xinuexpansion2 xinuexpansion3 xinuexpansion4 xinupageserver xlog xmail-ctrl xmpp xnmp xns-auth xns-ch xns-courier xns-mail xns-time xribs xtell xtreelic xvttp xyplex-mux yak-chat z39.50 zannet zebra zebrasrv zephyr-clt zephyr-hm zeroconf zeus-admin zincite-a zion-lm zserv
if version >= 508 || !exists("did_nmap_syn_inits")
if version <= 508 
    let did_w3af_syn_inits = 1 
    command -nargs=+ HiLink hi link <args>
else
    command -nargs=+ HiLink hi def link <args>
endif

" The default methods for highlighting.  Can be overridden later

hi nmapBanner ctermfg=197 cterm=bold guifg=red
hi link nmapNSE Comment
hi link nmapStatement Statement
hi link nmapComment Comment
hi link nmapReport String
hi nmapURL ctermfg=LightBlue guifg=LightBlue

hi nmapPortStatus ctermfg=LightGrey guifg=LightGrey
hi nmapPort ctermfg=LightCyan guifg=LightCyan

hi nmapProto ctermfg=LightMagenta guifg=LightMagenta
hi nmapIP ctermfg=blue guifg=blue
HiLink nmapHostName Underlined
hi nmapService ctermfg=LightBlue guifg=DarkBlue

hi nmapMACAddress ctermfg=LightGreen guifg=LightGreen

hi link nmapTimePeriod Number
hi nmapScanTime ctermfg=DarkBlue guifg=DarkBluet
hi nmapDate ctermfg=DarkBlue guifg=DarkBlue

hi nmapTCPPrediction ctermfg=LightMagenta guifg=LightMagenta

hi link nmapDeviceType PreProc
hi link nmapDeviceTypeLine Conditional

hi link nmapErrorWarning Error

HiLink nmapKnightmareComment Todo

hi link nmapOSDetails Constant
hi link nmapOSRunning Keyword
"This one is needed to get them to be different shades of yellow
HiLink nmapOSCPE Statement
hi nmapServiceInfo ctermfg=white guifg=white
delcommand HiLink
endif

let b:current_syntax = 'nmap'                         

