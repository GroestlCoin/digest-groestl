use strict;
use warnings;
use Test::More tests => 19;
use Digest::Groestl qw(groestl_384 groestl_384_hex);

my $len = 0;

while (my $line = <DATA>) {
    chomp $line;
    my ($msg, $digest) = split '\|', $line, 2;
    my $data = pack 'H*', $msg;
    $digest = lc $digest;

    if ($len and not $len % 8) {
        my $md = Digest::Groestl->new(384)->add($data)->hexdigest;
        is($md, $digest, "new/add/hexdigest: $len bits of $msg");
        is(
            groestl_384_hex($data), $digest,
            "groestl_384_hex: $len bits of $msg"
        );
        ok(
            groestl_384($data) eq pack('H*', $digest),
            "groestl_384: $len bits of $msg"
        );
    }
    else {
        TODO:
        eval {
            local $TODO = 'add_bits is not yet implemented';
            my $md = Digest::Groestl->new(384)->add_bits($data, $len)
                ->hexdigest;
            is($md, $digest, "new/add_bits/hexdigest: $msg");
        };
    }
}
continue { $len++ }

__DATA__
00|7DBC0745FC81F89CF3AE0148C42FC5F0106AF016D23DE296364FA0B03BEFDEBB284E87AC093132419DB98D7E1D73FBFA
00|5E3C94492BA39894AFECF3111FAD8A66556965EFAC94FCCCF753101F7EAA3637DFB2815D4FDA5BB530BFF45CEB67F7DF
C0|CAA67563A99736ABBF78524ABE7C90EB8FE2367DFE785CD3A4ADCF8F76D69CE8A041703F396A4F298B7053146F499E2B
C0|E8D755A3227427D7A897DE092EDDE6105B4490C4A7789A73AAE952638B05AC8D31876D5641B79F57482E754424095C81
80|078704F37CC3D1EA7989B6D421ECCAF81703CD02E1CA94152CE440AB6BDBBEDAB7077A2DC8AD8FF05C45D6BA6DE989D2
48|8719C75AA827BD485D94D3D3ADD28933EA0F1974DACF4733E06DAEFC4B4FA0567C7018B582A007E9F761743675C783FD
50|EE92AF9F781F84BDC78E4D229BAEAA19C07FFF357DFE99EFF23237D00DCE19D69B5A59F0CFBF7038F9D1440DF053C66D
98|215FB9619179F99917F605883C22909B35CD93AB0660233EA673DE64B08D008D39A7E20B4A8B526265FE163CAD57265F
CC|0E90F7C918B373E8C8E3B9E6C9851BC2524075C20B1943EC70034DC92D04663374A9AF24A968D451F2F31C7AE7D1DD92
9800|BD1504D7090ADC427C8A2250527F01E89E761C437BD08D81006000499E09A89596DCA3EB27CB6B863A9FB6CC165BB6B5
9D40|3B8334FE9D4E331E50E60DAE36E964581DFAB1EDBE29810F7EB03BFA4EC1F1EF7D372CE5F30E16DE54CB588211E7E333
AA80|94C55F72A577F97F9D2A8F52966923FB0D27840345491236EF5D46C25C44EB141C92AA327949CB55E49E54940D4BE0AB
9830|3B4BAD28C7919CCF83EF70DA14D4565CDEEF74D9E19F0EB2E9AF2566F84AC4E3A15578146FFBA1B0A4FBED3519B2A424
5030|42B8A7B702613EAE3787B0826AE85B234B0FA84566E1D11E907094F76729C3A041523D924445F5103495AF7F7AA437FC
4D24|8485AD8FC8857651DB491068CF92681C666B26408226887B833E6E8506CAD2BF70746B4CBC6B479C88C43CDD9774ADF7
CBDE|CB4978363059A1BE59DEC2940E5D48A941BF3241C6BE218C53CC2CFC5F7D49ACE86DC10AC10466E5372D0D20D2F6DE1E
41FB|96CC22ACA779BFC1544AC48F14A1AFE6A1984EF5D0D7C896A3D0B6D5FF42816D381B12003178E33B34DA1669D0AF62E4
4FF400|E5A483CFA0AFBC296F178B76431BE7DC250A388D76031A2B818088AD090F25F6456FAC0BD846951A1DD0486BA787F55A
FD0440|4AEE5AA9172746AF650C074177EB76252E5244D7DFDE13AF75E35C40FFA36658EED2D25834CF501A72FE6F486B069BF5
424D00|D40CE48EEFE0AF662B70729B1B7CE8A523C6D42B0DD94BA74D5721705F3874548760C29FECE84CAA08E9BC24650C1422
3FDEE0|02DADD7981970A78694F3B4BB47BF0D4CDFD6BAF4F84B190E3E3CBC4053F9A5EB2BCF6C2F1155EEBB4F3538FC4E6B6BA
335768|9F78C526F6B5C8EFAA6124F509B5CA8C895DA38C78473CC2104BFD44CE6DE60130F9593F7069BA56EF1383FEB9FD9807
051E7C|87EA94FCF2771C4ED1A6003BD7917E2BCB712A21E4EF94CDD6F73D84F76D6C1D18B019AFC2B41B64287DEFA0E068236E
717F8C|FAE10B6240068E7E6FCA4D18B0821E44ECB7D1C0830032240840EB62378EA603D6202255EFC6A1E08A551DBFAFDAF813
1F877C|F4524D6698CDA2BF4242445A77BF42C6F1C7B22EAB2CB4C3FBAEBC0D091A1E38223392A285F5E600AAC111A1A15CE5E3
EB35CF80|FFB1AC4D42479802DAE4C4EA754C656EE44F20DC75D4D52D3F4D4D6E7C4FEA4E80A9534EFD767581D80C33180B83FDC1
B406C480|9A5BFC1790934527D30701F293B5792EF7E25804875A9012FB456D278A5E5E73968C65FE66305862283E8F7919746D12
CEE88040|E9CACE6960FC653C883AB6F7673A34098E86108B100CB1738D9A0C427F8CF0B28B4DB627A822802E7212B0737378A14E
C584DB70|D2074A03A63877FF8B0C14F6509996556D8E33FC63539ECF395C0A6BC4030F1978CE626F42FBA6702B90931866460AFF
53587BC8|577911D33A228E102CCE96164F3D8D9E54AD4F801BBD7AB5199719467162EBD2339F07BFE7438A34F84E8E5E17ACE827
69A305B0|52DA852F2D40C7915336FDD2612C52369B29C6CF3B2AE1C6AC1167105920E215091FC605D0B7CAD858E5374952A50E17
C9375ECE|6EACF0383FD328707C9650E86B4D93903A8D06EEC01498521D26071D2CCDE0BD36B111D227EC72558C1B9932C4CB62F4
C1ECFDFC|F4057C582A85E01EAA73AD0E0385CC297EDF6B3A6E164F7CA777FC54F35BA82DCF5F1599971DB7D20358805ACE3B421D
8D73E8A280|D4F21E03F2B18144AC23DF4136DBCE024C16E21DB35667DAE00699102484191D842667A65ED6B11016575473C625A79D
06F2522080|948ABA5F34F55DCF3FBD0067EFE8E0FCDB9B63D25303FBC9CD3A3A830B51D1BA22C5DE2B8A0F03019948924974823726
3EF6C36F20|50A97002790C287AABD4C0F062CECA96041D13828434F001F8420DCA1B61B262D29CB8FB5F9E9F5A5DF898844E9A32B2
0127A1D340|EF507D1968631D45DC9D6199359FCC760FB755BA4A2229E26C7B09BC8C2A2AF89A5ACE9045034C5D86E1CF0FAE3D4213
6A6AB6C210|F3D9DC65C8B058CC13DF37F05EE99BDDF75BB72A1478443F000A205D26821885B6A4744C56D25CE2C03E83CFF29D5E77
AF3175E160|7A1326C010DBE91E6E6238C9B9882E334A89B30EA61FA022FFB14AF14070FF285312414BBFEACEA0F3D163230C03E2A9
B66609ED86|BF5EB0626A69E4C865D7277B23081A24B41C54C049666FEDCAEFD2CA33B15B9560EC5704CBFEDBEF87481E59948E258B
21F134AC57|C26F4AD3670155B7D1B3E97946C3FF562AA1C236F19B6E2C1FEF846E0F2E34E0CB72934775AA979D175A2C038E4A9843
3DC2AADFFC80|68029CA394B587044098D604FE993CD2E476BD53B77FE8818EB3185F542FEF79E30470BE3B7000AF91C1533572A2F9F4
9202736D2240|862E027AB6E1099E656B0D7708D9A115914B20763BD4E24FDA07E0DC54BC16DEDA99119AEEA64ADFFDC56830CF073F3B
F219BD629820|3FFEF761BDF6813682E70B66902B1B7B73871A6340E45B78243C6A5E27A403FF6169EF299BB0325AA30648BA90C066EA
F3511EE2C4B0|7E7DA22A066DE69E74A25C5936EB2A5FD6A7FFCFF0207B7A4B183C99D0E605154A350DB8BB1A41D24F383A6F7692DC18
3ECAB6BF7720|68123570DAC83C081C5264188CFE1EF194A73D0DE1B0E10EF6A1A726580522224276095F9C050CFEB854E81BA7579E98
CD62F688F498|8855A824F2FBE4BFF65BAF133DC095206FBD2881D39AEEF7C6B65B900229038B87E2CE2DBC0D5B7EA64787907C347E78
C2CBAA33A9F8|8B1DEC705E42F58652F53D1F5951632201153BF5FB70403D3A61EF32A45DCE5671FE64F2D0762C6E0EEAD44426E353BD
C6F50BB74E29|F7B9801359FB72F872CCF507356E9E8BB6FE7816D72B7CB5755755AB2ADD491871E84AB22FC4075A650F999A657589B8
79F1B4CCC62A00|F23A4E31FA3CE42F044EBFAA99C3AA06E17B9F52F518F34D7C919C916C7FDCA2FAEED10E3D1460D788937CE04AC58634