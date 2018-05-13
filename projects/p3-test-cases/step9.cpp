#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN

#include "../BigInt.h"
#include <doctest.h>

using mesa::BigInt;
using mesa::pow;
using mesa::zero;
using mesa::one;

//
// For these tests to compile create:
//  - mesa::pow(const BigInt&, const int)
//  - mesa::pow(const BigInt&, const BigInt&)
//


TEST_CASE( "Test mesa pow zero exponent") {
  REQUIRE (operator==(pow(zero,zero),one));
  REQUIRE (operator==(pow(zero,0),one));
  REQUIRE (operator==(pow(one,zero),one));
  REQUIRE (operator==(pow(one,0),one));
  REQUIRE (operator==(pow(BigInt{99},zero),one));
  REQUIRE (operator==(pow(BigInt{99},0),one));
  CHECK (operator==(pow(BigInt{"12345678901234567891234567890123456789"}, zero),
                    one));
  CHECK (operator==(pow(BigInt{"12345678901234567891234567890123456789"}, 0),
                    one));
}

TEST_CASE( "Test mesa pow one exponent") {
  REQUIRE (operator==(pow(zero,one),zero));
  REQUIRE (operator==(pow(zero,1),zero));
  REQUIRE (operator==(pow(one,one),one));
  REQUIRE (operator==(pow(one,1),one));
  REQUIRE (operator==(pow(BigInt{99},one),BigInt{99}));
  REQUIRE (operator==(pow(BigInt{99},1),BigInt{99}));
  auto x = BigInt{"12345678901234567891234567890123456789"};
  CHECK (operator==(pow(x, one), x));
  CHECK (operator==(pow(x, 1), x));
}

TEST_CASE( "Test BigInt pow simple") {
  REQUIRE (operator==(pow(BigInt{2},3),BigInt{8}));
  REQUIRE (operator==(pow(BigInt{16},2),BigInt{256}));
  REQUIRE (operator==(pow(BigInt{4},4),BigInt{256}));
  REQUIRE (operator==(pow(BigInt{2},5),BigInt{32}));
}

TEST_CASE( "Test BigInt pow 12345 to the 13") {
  REQUIRE (operator==(pow(BigInt{12345},13),
           BigInt{"154662214940914131102165197707101295849230845947265625"}));
}

TEST_CASE( "Test BigInt pow 12345 to the 45") {
  auto a = pow(BigInt{12345},45);
  auto b = BigInt{"13094811226427701098032226848170118913275798988218088943760507394821471757763133456661996612699586253400201140280721065740690646142413399669123817828339866764508769847452640533447265625"};
  REQUIRE (operator==(a,b));
}

TEST_CASE( "Test BigInt pow 12345 to the 76") {
  REQUIRE (operator==(pow(BigInt{12345},76),
           BigInt{"89809683185212804313008590812233876647338571579892927466849454284663257073903269336303509605514203139697033833473488783783618498724869064384830048802777443995972836642193974596334478331126278167756953508838959721882846719565795458153372274874998466929854928011517663081521301027265735683613456785678863525390625"}));
}


TEST_CASE( "Test BigInt pow 9999 to the 99") {
  REQUIRE (operator==(pow(BigInt{9999},99),
           BigInt{"990148353526723487602263124753282625570559528895791057324326529121794837894053513464422176826916433932586924386677766244032001623756821400432975051208820204980098735552703841362304669970510691243800218202840374329378800694920309791954185117798434329591212159106298699938669908067573374724331208942425544893910910073205049031656789220889560732962926226305865706593594917896276756396848514900989999"}));
}

TEST_CASE( "Test BigInt pow 1234567890 to the 99") {
  REQUIRE (operator==(pow(BigInt{1234567890},99),
           BigInt{"1148107991131665323171698904283135590463404846281249735904801669185448933261164100492984822324956937703914143052434964338629820400466161582767117327772647848503448725760109107501992564470573765020516097757713981873984714668838575129463070926510644168653614947871234387436881945258474617800659512499223386092660371338157407661633602918605092251032604280512855026214361426685490207410486809997707617730952196472417357241685283415473004245784831537268909459698346629282233486012817910424433527473719518760222174239739370524471900171991956679352456634674585260858193826571048386126574129758959340295849957043537320496617418527601100156408543216327050834245142914490278562900675414691518797158973853625610908260601859322700655173648322959855328760386810637122135737573587031338226868347170501229759984584109000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"}));
}

TEST_CASE( "Test BigInt pow 2 to the 9999") {
  REQUIRE (operator==(pow(BigInt{2},9999),
           BigInt{"9975315584403791924418710813417925419117484159430962274260044749264719415110973315959980842018097298949665564711604562135778245674706890558796892966048161978927865023396897263382623275633029947760275043459096655771254304230309052342754537433044812444045244947419004626970816628925310784154736951278456194032612548321937220523379935813492726611434269080847157887814820381418440380366114267545820738091978190729484731949705420480268133910532310713666697018262782824765301571340117484700167967158325729648886639832887803086291015703997099089803689122841881140018651442743625950417232290727325278964800707416960807867294069628547689884559638900413478867837222061531009378918162751364161894635355186901433196515714066620700812097835845287030709827171162319400624428073652603715996129805898125065496430120854170403802966160080634246144248127920656422030768369475743557128157555544872757101656910101465820478798232378005202922920783036022481433508257530960315502093211137954335450287303208928475955728027534125625203003759921130949029618559027222394036453197621274169610991353702236581188380423306516889353019901706598566746827311350281584968727754120890486405491645657201785938762384254928638468963216610799699938443330404184418919013821641387586136828786372392056147194866905430803711626645987406560098802089140982848737949082265629217067979931392065064092703141738324544345260523790441307911980992885061203522165291537934519659802301702486578291604336052956650451876411707769872697198857628727645255106155473660805376737412870387636993174149249170378468977823319310937284749639508286051850682216567908607155895699111491922923667220135482091425502536463874182275289317250550426493906194736964349770417173079403521979559492907572889588571809849364065729741891601040737491085929005694535614125452913408718110288737960708826857843862807452291452496230514315040767791654065050993837928117171769477704587811700422443763081321784324416759731860188646620047228123461627175200339013636918877688203363449318120518745705483359278525379549050123394940089135962976690641210977014151379704224477507338334194848998443120818156688196951686727900703818370938855527692112869749555093234109848290825742565247111184973857381534577734108841438100181388628861890682665805598405640396334740943600649321830384275819930267301148935778758973692623184723461543947132974108504025560161182748144084517869560684169196795878209366925255485135806957719795495799077327208668155828468015561124968984999613390866179011555931322287649567879087504099919618142307624940544480116122181086885809043178507734242029311164896426937811743278220268481311009481785514406180783756271669151635014548834325284278578752758363759449597064855668845074958090657585772003864325286594778725460165092652423556909157703662026659519231042018210881851955775319894500371426836098140451738987266660234184397934290118976109314560040371409775658974078812224149259230754852444013637360787344065797375204866057540249095227901708413474893570658031605343195755840887152396298354688"}));
}

