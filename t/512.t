use strict;
use warnings;
use Test::More tests => 19;
use Digest::Groestl qw(groestl_512 groestl_512_hex);

my $len = 0;

while (my $line = <DATA>) {
    chomp $line;
    my ($msg, $digest) = split '\|', $line, 2;
    my $data = pack 'H*', $msg;
    $digest = lc $digest;

    if ($len and not $len % 8) {
        my $md = Digest::Groestl->new(512)->add($data)->hexdigest;
        is($md, $digest, "new/add/hexdigest: $len bits of $msg");
        is(
            groestl_512_hex($data), $digest,
            "groestl_512_hex: $len bits of $msg"
        );
        ok(
            groestl_512($data) eq pack('H*', $digest),
            "groestl_512: $len bits of $msg"
        );
    }
    else {
        TODO:
        eval {
            local $TODO = 'add_bits is not yet implemented';
            my $md = Digest::Groestl->new(512)->add_bits($data, $len)
                ->hexdigest;
            is($md, $digest, "new/add_bits/hexdigest: $msg");
        };
    }
}
continue { $len++ }

__DATA__
00|A94B5251DC711C2813D70D58DD4F84648F90D2700D9417B4C58070069CF68FA86A720E7EE409D64D06ADCE285BFD60E09D5BCFF5BBE7CA2922B96869AE6489BE
00|C5C8029AAD65D0BD24250A55E94FBEED2EEF1F3F64BF5410FD0589666CDC9D75F9BA15C88AEC0F252D4D4DE41DB420349E5426639AE5605911FF7C77480740A4
C0|349B040501E79721184966E470C2D003E9EF0DADEE27266074C7513D3E428200B80683B6E69953FA185302076CD021BCCF9CE1F0E57ED33E24B03821E3FD8534
C0|0601FF8C6CE231F24FB0FE134077A3A4620D05C1BEFDFAEC3CCC96B2589B3D2CC8F62D19516991F072E95F617C7A56D5937BCBD427674B65B8E54C3C0136D381
80|F1820A8F4219B7AE442B8FF2D9A7ACA49C4B47E71119A35A21EB21BBF1A267129AB7B0E3E3DCADF3CF3C06C2A32C30BDD7D8765364B320228697C84E0BD0DE09
48|93A51B595605106E55A82F16FBB5F114DAD60F287B74E29E203F882021592F64285FD0CF4FEEDC07D0EF87A2D8122B1271431BE3A3D861574943AF7726748F4F
50|4D7E875AB5B5774CE41EB0DCE2801C5A00247739B691A916E1DB6F28B8B9F295D864821C87C3D6A2A6C41916D59C4255CA3863943E431BC78B20BC224C74176C
98|693DF9D5BFB62FA43A7C1C711969DFD00B5BDCF8D7C3771A171077968FA502FDE66739CD783F5673DF54A09719CFE449D4FF263175B43B2EA8DEC7296975510F
CC|9E39217597B7052D64661987CD560F71D70C1552D2B5650023250ABAB2E7D63E93F816BD33C25C3CD5E9D61699EC0FB1F5F8965DEED70E8BA2163BC7F134D25F
9800|244E09721EAFC89B3EA9406282F2CCD3AB7CE32477E96688225FF26F3DBAA76CF21A056A69D6D922F3112B429346E3B984B036A65719F14104E098644730D4E4
9D40|C4D289A46773E704E2331D8ADEC2E4F2972BCBBC4F5091D3972896050ADFD5834CEBCBB0911CBF40AC0F801241B554E1631607C43534560334DD57C43F6AA2EB
AA80|122F8C6CFB7FB2B164C3005F293C82CEC7F5A0055BEE972364334B1FC2F48A045E61D9D08F6B0D3D95FBD98E910181873A606F303DCB4225CC758FFBB695032F
9830|3F981763AFFDAEE38BBDBCAB7790E890FD1DEF6B9E96D0C0989B69B6CDEA1FECA4E93CC008514C888DCA1FD02FE715820CD1E4C36DC8492C94EAD239E1A4D64E
5030|A581C7B1EA519ED2FBEAE64343E59C154503D6AB8ACF0CBA9D6F16E08EAD9A56D7408FEA3137C313DEA4CEF15047365F99D82539969EE4BFA733B81804858439
4D24|2770BEEB982D5368F8AD42D7E86D8367745210A06BF38A4E266E8026F09CF5052CADCDCE732804B3F380B5EF8CC7C117A0E2DBBC499B78574A18433E2C52E2AE
CBDE|A802C7DA167CAC8BCFA016533152E15EFBF49871261D98F739CF97B2B956C1CB06383C986189CA00DA5626540478C8F9E45814B04C9F39F5CBCBB13E0D14E212
41FB|1A4EA42572B7D934CACE39D4F57A87AFCF3162CAD97235172D22E82B256A657F28201AB79F809E057CDCBE4E455559E9EB9699BDED0FB60D0CCEEB18E2CBE876
4FF400|110F886FCD3F725622D626F51C57618C73950646386CA8560269D34A611EFA4445584A155A20594A4A8C64EF77890EEF607E14658BB2D70BDED4F2059C00294D
FD0440|5E6B49D9C053324CE0BA0DA2B6750ADAAEA1EEA2D1F242A5B129A89CC64402728853385C7758BB57D4B5600E7613A7D7C724AFD73DAA066FB73BBFA4AD8D87B4
424D00|9DF52574CE1D25FAF7C62C1A3E6EF295717C59A9F90BD97BC9DF21005B3E763ECD75520613A91DC6FD8E56B7FA29A6DA708E46E9F8F742C665225517ED60C947
3FDEE0|1B6120002348236A80676DFFD4E2C3B50F710F73C1D6461A878D1D9168CFA15C8B391FE26EDF7965FBBCE0449F2917DD583BFBEDA3384B9B870667B808D5515B
335768|B922582AC7726FDD6787EBCD6BD62917F6B045338BDC0B239AE75A79578837197A3E05C061DB176B7AE1259007AA3D3870B68B0E1C9F49FD9209FA351484837D
051E7C|52335138A2CE78654553BAD5F3492057C43982C2762050E9A4232A034DE17BCA73E95C696B5D5FF918F2FA5955117215324D4DF69D0F6A830B5AC5C7CFEF347E
717F8C|64D8C09144F174A7A7FF069210D8269C66D29BFB53468C2EECF998186F73B95D7C8A5E1FC479B763552FA305573764FFBCD7F7A1B18C4C174513FA282AF71530
1F877C|C6A8A1C743A5F050B01FD0A84A8E9AC5D920288AB8F4A4837B18DBE170C8DBF6AEF9C2B846A6A9649F601C451FEB09FD1FC527C230E5915D5026DDAC5CC31FFB
EB35CF80|EE009CF409DBFBB92E2D7BB402ABA14B391E4CA956A5AE89338EF0206BF07553D8E9CBC5730C44E42ACE64E6AEF79E4049299581E7DF09A7DE39DFCE71FBD31A
B406C480|64736694B09B60E8054665A369A7D1EB2D9D916C19BD6679C573794F470AA800455DDC916D96CCDDF4DF8A51EDDAD74377524679F8AD3402D8D768547B4CCCD1
CEE88040|1B63AE7D52DEE2FB12FD8E7A9928508B29EAF7D1308538BBEFB21F2F963957B868545C9276AA24BE12BD05659E2C2EAE9D4FAB780113306F1D750C1A410F05E8
C584DB70|B87C1680EE6619B265FCC0F4218E1D9B18C856C8E3C9060400CEBC1FA384B5C978471FFAD936BBDA4167552B32A532A076F246300AE13C11CC5EAFAB185E2BBD
53587BC8|9D0CA7F077BDEB6F3E16495760EE6BBE90491FA05E8A99A81DCBB329A1263E596B8B4A0AADDC18D634E29C7744D0F07BF1DCB294E5304B9201C312E45369B8C1
69A305B0|307573356CC80213047122BB4FBC0FF766F8AEB6D91F2676829DACF083EC9C049340AEA96168D8BED98689EF401FE294750EC921D20F8DFFDDEEA85E6F5E42F3
C9375ECE|2D7EB3A92A00359BAD761129DA9DCB8E0BCDC210783FB9A8F537A2CEA9A8D093E5FFF380BAC3E3BFEA6142EE39B9155ADFC558312DD422CEA0ADC7039384DBED
C1ECFDFC|3A5F9F9791EF7D6E2C542BFD8CE7F5561430D59025111BC4F650DF0F34FD292C8001DEC979DCDA73B811B9972238E833F2BBCCE2EFE592483260B81FC47AAEC8
8D73E8A280|D0BCD41B5F35C2F3767F08CA853F2077FA3F132A132D476E911D7B6C733C9DE7929B2E966EC88B9718267B8F3B07E2B14CF0BEB3642412F4C83CB43D3A9F2D43
06F2522080|635047CCC9217A1E73402D8EC5BE7771CFA83E4CE81C0F60C3D210B49B3865BB3608315307744B0B92C9356F8CB582BA297EBED1708AF8F09A865E112736992A
3EF6C36F20|E998104C7CDBAD855552FEC6E071735F8B12BC3DF43D48CC0820C40B207DFBA2BAD5EC2002ED151ACFD35D7550AF6DDF5658CC2E76C3F83835C05B354780096C
0127A1D340|522A6E2801AC6F9C07E23CEA46EF28B788E8589D3BD5501B736D031F45434C76DFD824B45514DE641123CB7575A4A6419B985715459422B2AFB07DF8B2EB0A16
6A6AB6C210|180030004296D59DAB4A0CD749092C224269FB6B8B9112D956A512954B07987E8EFE55A4B98B611FC7727E6203945A560E9A3E249B935EEBF62E10EE28BA0AFF
AF3175E160|26C56739384D66C93EF9A1A482520A065CBEA5000F5D7145CE2B1EE37CBC1CC6F4BB31495A663A36D1EB2A3A1A23F976548B2C9663F5336A33EDAF43F18F02AB
B66609ED86|0543DB1C24C058EB61E1DA60F1851FEC728C24B755202BB25EACC37CF9A064030D327F85F1D4FDB5DFB0EA9F0D173626E7FCC0F7EA26F9345A4BF69668D32C58
21F134AC57|BAB54974E442C31E70CB75BC8394D39F5276A58E653812144CFDF0409E644605DF16D49CC2FDA35E0119F4069CA718FB6CDA480B9BF60831D2DF0A8C6D4F9742
3DC2AADFFC80|0392A1C0CB5AB71395CE2CC7DAFE05B0C3F2A2178E2F9A48CC3ADA57547AF6758F8B80B1D7FC42A06D230F8EAB672529753CE3BF00B5E1301E69FD1AC3D8B09E
9202736D2240|61D37B32B4F4A12212962D01868A50BDD5A19E5B87B21DA5C8B8926FC4CEEAA0BB5C6E511B77995108BEADD8E4A1A31EC7E881F9C10EC65B1FBC28361FDCAA61
F219BD629820|E8C7644206CD91B3C538EE94481BDF2ACE55BEF93D082AE4A3A19D14415B05EE8840A2BF68CA28C57358E4EE00374D752BFA6E0D94982AF838DFA3C9A4180F41
F3511EE2C4B0|89AE3B28F526CDB14C33B7473EEB6E71F7579DF8229726216C2CB01C290319A8C15A8EBF70362AA4927984B497CAC9D1291E723D47A5829CB6E245425AFDBDD9
3ECAB6BF7720|6ED9217CE0FCFAB0B3BC3F4EC20A38D203E0E315A85C58ECCFF68842B1521130F7CF1B3E37D8238428418DFE682AC8D7FD4976BE389DD56B3E9C60EB81AB3ED0
CD62F688F498|D7A97DDCA241E992C9EE7CB0A31A53223261A1383B34E28C33D08D141B3236C242C1F681E7812B3EB7CB556E2BFA01BDE821CAC1F95D760FF905294AD1A8A74E
C2CBAA33A9F8|529894DC7A0660331DEA92FFF7244E0EA973445D13FCCE896C14650886E59DBE6606C60D7C33496CC4E95E2B60E517F333D8F308E2C26570A2BF1832EFF0B1FC
C6F50BB74E29|07AF793B66ED3B81373BC0F76A22DDE6F2D74635F8424D7455B80DCF6CE08BE604CC0895BEC251D20AD0BC552A19113AF88F2985BA8FC3E3F2C25FDDE31C5DB0
79F1B4CCC62A00|C1A722A460B2F5E3646A9191062C3D8BFE137FA6AD909590898E209F220325DC7CD47AB3AB447C1835CEF9012BB5692FE8CC55A4C1DA1DB09BFDDB3F1D533E03
