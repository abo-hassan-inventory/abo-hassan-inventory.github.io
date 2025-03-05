'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "86626954c392ef75d6d1543f27ce6b53",
".git/config": "8d85c0fc0a773d03aef69d33ff38d166",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/FETCH_HEAD": "d41d8cd98f00b204e9800998ecf8427e",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "9e89fee8beaf8ea6ddc0132ee6755a68",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "8888a4e4dd355afa56ebc92e77f02483",
".git/logs/refs/heads/gh-pages": "e0cb3ce5c11327a1ecfe60baf6441825",
".git/logs/refs/heads/main": "f00516a3d0b2165cd85d21c7c0ac144e",
".git/logs/refs/remotes/gh-pages/gh-pages": "361cc27af394d05ae9c7d94864c9aec4",
".git/logs/refs/remotes/gh-pages/main": "fda4ecdc24cdd1882f4b24a1f1840741",
".git/logs/refs/remotes/origin/gh-pages": "c7dee968c3c65fc4465e89549aa0ffbd",
".git/logs/refs/remotes/origin/main": "46293f42f0839ee02536a39153c62f85",
".git/objects/01/150e55aec213c0d0122cddda1f23fdc17b2b0f": "0a081a2ef7d2146f901c7b88e595d0b6",
".git/objects/01/69ccda700bb723050ba935277661fc7a554e31": "9331482d99dccd39b8d2e518cf3b590c",
".git/objects/02/d379985de129bf1118143f9405993014d84a88": "49a3fd720a605cdff3cce75df2a0f8a8",
".git/objects/05/a9058f513cce5faf1704e06e3c150688b0a01f": "e8d02f60cf87abd4c1de4b153dd696dc",
".git/objects/12/6ef5c2358fd7e0f87f8c04096291b950972361": "f3a314dfd3f28c0aa96ea722240282ad",
".git/objects/13/a332de44cdf5853927de73a57b66b7680950f4": "69fdcd923006930f865c357204ee039b",
".git/objects/1a/5e0b1d6015687384c6326919a0bac2705b9bad": "c6df129eb2d3a8284b0fc767c9b437b0",
".git/objects/1e/366dfd55a43eeecb73d4ee46182ee1c6c3e17f": "54a69eff25be2c5ede68a272e10a2257",
".git/objects/1f/45b5bcaac804825befd9117111e700e8fcb782": "7a9d811fd6ce7c7455466153561fb479",
".git/objects/26/3a79f318f7bbabd18fdd42ff56f72489932b61": "2dcbc817c2aa7b424b4d0f6d05025513",
".git/objects/27/035d2f5077fd3106cea15e09a8dd9dde8c219f": "3c2c541352aafb59d66113603658cd77",
".git/objects/27/a297abdda86a3cbc2d04f0036af1e62ae008c7": "51d74211c02d96c368704b99da4022d5",
".git/objects/27/cd35d151c9b4deb795b6566ee99ddddc4d110b": "3669562f1e21d89c30048db2f7942449",
".git/objects/2a/530d101b9ee94834f16b957a7171c1dc42eafc": "1043f8ef2b72ba5ad29f74645eb51160",
".git/objects/2a/b33615d2b45abd8f9cd606533b5cc77599d3fc": "e24769b14e5ad748f1a14648817c14d6",
".git/objects/2b/9ef40880d845fe265005a3b1f76fa16606f877": "1dcf24ae9b9349b9e1383910595d6a53",
".git/objects/2e/d86935b1b23e8da904a2f545d8a493f2caf20d": "e6e197dec23f04779e3dd1bd4b7e27cc",
".git/objects/36/c11467e9e7a22e6b87ab0f918d174d98221f39": "d8ec4500b1f7bb8584b07040f2a6e81f",
".git/objects/39/53765b2602dbece450c5d27162a0a03a17431b": "b26458eee6947bb704c080b5fc523fea",
".git/objects/3f/5a72668927e7f028ea9da20bfa03be0df28af1": "7f39292b217c1842f0a1832c93f84e02",
".git/objects/44/0afb0a89405e1f91a7c8544b7efa211880dcfe": "05ffd75e6d2f5da18dfb3cd28fb33601",
".git/objects/47/42bfc6f4292547196d8ce41ce294acc35c3ac8": "bef3ba2a9f8546a780855ec79b582718",
".git/objects/49/7c40924a15e43a99cce264489cc88bf5815271": "e45b44d81465be6063098abe95b75459",
".git/objects/54/a6aae0f5a4d3cbce149eea5eefd56468a0afa7": "90b7557cfe54e9268eb58a514e0d5372",
".git/objects/55/596c33fa9cb6fceba391d6004398856325daeb": "53f3d48ababf8fa52cfc493699cbc274",
".git/objects/58/b577565bd5796d8171bdd8e04dd3e2b3bc851e": "8d953838f2eeb582a899312204e5e647",
".git/objects/5c/9bd6c729a1605d6a4684ea59997435586b5da8": "a1beca73050e7c7c6ed011da1b63c751",
".git/objects/63/1ffcd65fa8b730bcdf30e4367d9c205c8bf00d": "84262c8abf2d4b407789c6e2bd6c2045",
".git/objects/63/6931bcaa0ab4c3ff63c22d54be8c048340177b": "8cc9c6021cbd64a862e0e47758619fb7",
".git/objects/68/635a3ecb5c7f2b8ebaf5473d260003eae64044": "5d8cc677bcbd6b3e6e17e3e81fc5a5e4",
".git/objects/69/bc8421f20f5f9442cf317770d6c6859659a8ea": "39f3cf27758962c85928f663321a78aa",
".git/objects/6c/aa5c401c6bc91cb45dd7327d06d28a2c90cba4": "04cb6df143bfa137305251429b400b86",
".git/objects/6d/5f0fdc7ccbdf7d01fc607eb818f81a0165627e": "2b2403c52cb620129b4bbc62f12abd57",
".git/objects/73/7f149c855c9ccd61a5e24ce64783eaf921c709": "1d813736c393435d016c1bfc46a6a3a6",
".git/objects/75/2fe10faec5ebe27daefdd43e4f71e33d7acd99": "d81e914cc5702a497f99c153e81bd299",
".git/objects/76/526c3a0290f317d1d65b1450d4cb16030bfea9": "3ec51382e3b92108822eb03c4b9a28d3",
".git/objects/7c/3cc9cedc8f079bfb026964327173879ac567ed": "c981d6248c32d35ed88ab4c43389a313",
".git/objects/7f/c4deea22fbd8a0a2696a5332989afd192994f1": "17e3f01886b95a866d1b935e0bb9da52",
".git/objects/80/a799c6a117bf0f32c1ae4218f906b4c05adf84": "0ae0d15912ef2a9710a39b91a213def5",
".git/objects/81/084cb14261897bd85ab030a14505ce48668f0a": "427a219436858f0365bafd0aefbe509d",
".git/objects/81/11eee6ff66ac52e608598a3a42b2000310538d": "52d5dfba628f2595a758f037f47ce9ad",
".git/objects/81/2128e04663fd1361a2825dd161ea75e743787e": "da31997e87bc44ca01cad292dff47239",
".git/objects/84/76fa6bcdd76d413d10edf498f55a173bb238f4": "76aff4131534169db27c47d73394fbaa",
".git/objects/85/0438c57f682d615f9b33c9564a42aab1e61a41": "a4f72337ac8a6efcf20e77e70cfe4f12",
".git/objects/85/6a39233232244ba2497a38bdd13b2f0db12c82": "eef4643a9711cce94f555ae60fecd388",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/89/087b4b0162899d655a13a5a5770274877612ea": "bfa64f3d3f3dd8f2bf9ec48e9f5ff466",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8c/59773bee8314a8ffb4431593d0fb49f52e34c6": "2eb993d30677573ffd0e58484cc6a514",
".git/objects/8d/534a6c5b1033debf92464431c2658a10ddaaa9": "3027c89f2929ca675a9d990326b4912c",
".git/objects/8e/43348425025642472272313061be3ca997808a": "b613889310874c13f57313072f63a7b8",
".git/objects/95/cb426feebf3309d0cdc687abd9164411dd23a2": "99609a077ab1a6f36b4d0217787d7915",
".git/objects/97/8a4d89de1d1e20408919ec3f54f9bba275d66f": "dbaa9c6711faa6123b43ef2573bc1457",
".git/objects/9e/0762ddd248158813077c920805a842d2ca7939": "bb71364d84ec49dcb6594bf0619093a9",
".git/objects/a2/82dcc643006e45658968bac6e01f18d8302bdc": "7fc476bdd86df6bdfbc9395428be4507",
".git/objects/a3/c5c5b5ba4aa32e509410407d1eec86a0204b6e": "ac38a0a40e4508aaff95cde6844007cc",
".git/objects/a9/0b470710b2288f3378db5ffcfec06cad0ae570": "5841de94cee7fd4b58b7fd4cae34866a",
".git/objects/ad/af96380ff2a9f682c4a10d95afb3b4c58a8433": "cec23c9105ecbffef78a1cf1f49ab6ff",
".git/objects/ad/f49678a1aa421fa97e4bc691c56c47bbb45da1": "43f8ff8bcfe5635f3b580e645cc4d785",
".git/objects/ae/d3d69c05e5399173f9108726ba29f8c5316c38": "c1df70faf8da8d594b0c69acf3bcffb9",
".git/objects/af/31ef4d98c006d9ada76f407195ad20570cc8e1": "a9d4d1360c77d67b4bb052383a3bdfd9",
".git/objects/b1/5ad935a6a00c2433c7fadad53602c1d0324365": "8f96f41fe1f2721c9e97d75caa004410",
".git/objects/b1/afd5429fbe3cc7a88b89f454006eb7b018849a": "e4c2e016668208ba57348269fcb46d7b",
".git/objects/b2/02da4e72c4ed5431b0098eefdedb5bee68b244": "d40b0385490fea6ccc636d35c368b199",
".git/objects/b2/49891968ee0df717a3182515d1ed132f3a05c2": "3f964f8847f026e97aa2a859be05e6ac",
".git/objects/b4/e4b3270ceea586c85c84e6641e3e03854dba38": "451232a1520ccb2cc004e9f4d9b9664a",
".git/objects/b5/379d6e77fbfad10cad0ae3184363f6d1561036": "3080af10963ea38c151b75e2d931108c",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/536ae5f8b11ef67778587a48eead65677fec87": "1545af31ae1cbb014f65cb42a85a4d87",
".git/objects/ba/5317db6066f0f7cfe94eec93dc654820ce848c": "9b7629bf1180798cf66df4142eb19a4e",
".git/objects/bc/26f23791536cf08dd39762b91f0688dbc3eae8": "8a98e5da63e2f5ab93fb20cf9c552a69",
".git/objects/bc/c4d3c27588a0e1e73345f7b1ae009e1fc3e7b4": "c565b2a2c5a664803c3087b32e8943a3",
".git/objects/be/c872bb3121b70443bde0c76a729301201b1730": "1a5a8f0db0b2cef2152d5dc362051b9f",
".git/objects/c1/dd4f7fa968ce9b7f70d102ab66ac65d9231a10": "f73989870442d6ba2df5c7a7099227aa",
".git/objects/c2/0a3270205222b1c9d9deab0022424b89f33588": "1def085670dfbe22a107951a5e16f958",
".git/objects/c2/f6b6c67e6cd1c018030e8acadc728592e86bed": "fe578165c7c9a4cd3625dfc9e3704087",
".git/objects/c3/e81f822689e3b8c05262eec63e4769e0dea74c": "8c6432dca0ea3fdc0d215dcc05d00a66",
".git/objects/c6/06caa16378473a4bb9e8807b6f43e69acf30ad": "ed187e1b169337b5fbbce611844136c6",
".git/objects/c6/0723904495b528a975c4c201da5e97bec27479": "2265d6569e655380eefc9e6ab4b95d1a",
".git/objects/c9/2e201080a47ad185e99cda06c82b7f7eda89ac": "87132120d4c1a73f3ddbdd5235fbf814",
".git/objects/ca/3eca61f83cf4e8df6dd05a3b4104b517a567ef": "c534884f1e768a62d0f6400ef41edaef",
".git/objects/cb/c1fe5e8c3a7ce995f8893bbf57e2bc64e45af5": "d0a364c261e5ba996b4d156de41f19e2",
".git/objects/cf/aafbc87da81366478b4bb50283896895f61580": "7a4256b079ff0948e6aa023b6f5ab9b7",
".git/objects/d1/23514e89717662a6db3b8afb3b9893c34152ca": "a08ff3af213c408e378c9dfbe5886111",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d5/9bc46cf0e055512d784fd00be8f9f3bc64ea68": "d1c71005d2f82325a7b48d1285df0d94",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d6/a7479d88f6e98c02ae4d14472c4d54eeee6ccd": "21252a9b7ac6e6bb7879734a3e740cb8",
".git/objects/d9/c1115da095c8dd89cdf102ce40657598a7225d": "ed67d3a6c25d0e01e5b75ecedbb55a5e",
".git/objects/dc/db33c0bf1f6f8827d967bde45b9e1d58e72074": "712b181e945d56a82483909d2e509953",
".git/objects/e2/3bb5002e0559f7473a2823a0c3232e3596451d": "29a9bd67869e0d5586b49d9e226d1a94",
".git/objects/e4/d721a9d2c36691acc3fe25f18c65fa65528772": "5af5740ced8172628a9239ab3cd0569e",
".git/objects/e6/5ea04d066bca31ffc31d21e7da6cab0f4b41fe": "575a268435ef1ec07b231bd29982e3e0",
".git/objects/e8/73264c3fa6da2619826772d5bf2546632b5142": "5d385c233a1cb03123baaa9ae60b9e6e",
".git/objects/ea/011f47960a0407d2568050b55a70d0e745e230": "dcac964d5aaad639b3a676fef0994db3",
".git/objects/ea/60b832190a6e25d1400090b08bfb3191f44147": "8fa4bfd7a4f09c97014ad904ffb0a61d",
".git/objects/ea/99f8990de53d7085fb9fc704ad2b2728a7c700": "c1065f1df5759d7094e0bf053a6a9351",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ec/361605e9e785c47c62dd46a67f9c352731226b": "d1eafaea77b21719d7c450bcf18236d6",
".git/objects/ed/7036ddae5a318489e2b02b662226068d8b4117": "f70c32481537b9b59e1b2424dd84f579",
".git/objects/f0/7b9a91106fef2440869fadca535924e1518b3a": "992a8ec7ccc00efc965e60879fa2115a",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f3/e013240ba5b1b2aee283a614cbcc086274c775": "cf3fbb22bcace281205d34a6b222c77c",
".git/objects/f4/5d7ede90d52a7eb2dfbc03aab6fbde687676e5": "c778713b82f7f84439ab32d5abc181de",
".git/objects/f8/034cf6238915a6a42597fa07ed418e96e0652e": "9861f7434a0013e32fbf33716d033804",
".git/objects/f9/3f1134ea5df4c6092d0a6177fd4c5794f17c2a": "f80a1579d22adf83c3525d2a1383e6f8",
".git/objects/fa/f209740ae0b9c143b1431149f2159718c92a3c": "5403b61710d3a73eda0c450e247a544a",
".git/ORIG_HEAD": "10cfd20c21fe7c1490609c86790c4f03",
".git/refs/heads/gh-pages": "e4d36679a31aa7f8ebe665d1187fb7b9",
".git/refs/heads/main": "10cfd20c21fe7c1490609c86790c4f03",
".git/refs/remotes/gh-pages/gh-pages": "e4d36679a31aa7f8ebe665d1187fb7b9",
".git/refs/remotes/gh-pages/main": "fca42f1373eed31aed4a7d8200198c22",
".git/refs/remotes/origin/gh-pages": "e4d36679a31aa7f8ebe665d1187fb7b9",
".git/refs/remotes/origin/main": "8f6626d1922d366cd447bbbe7d8fd983",
"assets/AssetManifest.bin": "a8c652a49784b9b06bde0602f79b3494",
"assets/AssetManifest.bin.json": "2362026a142dbbbf6e0f7d403f1dd572",
"assets/AssetManifest.json": "aa807dbce27a40dd4cbc820af5e5f947",
"assets/assets/AssetManifest.bin": "c440e90261ba276bf53b6b748132a1fa",
"assets/assets/AssetManifest.bin.json": "f07a0b7d292e78c10a2a0bfc73ca7079",
"assets/assets/AssetManifest.json": "a01539e0bf8b12a4ad5c38c6ae541700",
"assets/assets/assets/images/1.jpg": "d5ce8a621dc5e8072bf4bfeeb5d3b8bf",
"assets/assets/assets/images/1.png": "7221a47c0add2e78c66db9dce271f88d",
"assets/assets/assets/images/2.png": "d5df9053dc7b3348c971cb8332db4ded",
"assets/assets/assets/images/3.png": "d240dc69f94cb6d2750be7e0255c249c",
"assets/assets/assets/images/4.png": "a762c70e6174b0b22e8440e484f32268",
"assets/assets/assets/images/5.png": "0c6975293d1da3d587832053c2fece4f",
"assets/assets/assets/images/7.png": "981965c3b40168602069a0122edf9767",
"assets/assets/assets/images/8.png": "496f61b496ea4ba5d0df2b2f53ca79b2",
"assets/assets/assets/images/9.png": "c087f53883b38759dcaa62a620a7a8ec",
"assets/assets/FontManifest.json": "ac3f70900a17dc2eb8830a3e27c653c3",
"assets/assets/images/1.jpg": "d5ce8a621dc5e8072bf4bfeeb5d3b8bf",
"assets/assets/images/1.png": "7221a47c0add2e78c66db9dce271f88d",
"assets/assets/images/2.png": "d5df9053dc7b3348c971cb8332db4ded",
"assets/assets/images/3.png": "d240dc69f94cb6d2750be7e0255c249c",
"assets/assets/images/4.png": "a762c70e6174b0b22e8440e484f32268",
"assets/assets/images/5.png": "0c6975293d1da3d587832053c2fece4f",
"assets/assets/images/7.png": "981965c3b40168602069a0122edf9767",
"assets/assets/NOTICES": "da0567c82fb7d476324cc0e847ede8e3",
"assets/FontManifest.json": "ac3f70900a17dc2eb8830a3e27c653c3",
"assets/fonts/MaterialIcons-Regular.otf": "b324678b6dbe3a3da53167ef4e401b99",
"assets/images/7.png": "981965c3b40168602069a0122edf9767",
"assets/NOTICES": "b06b4c6eed10590af06404cf548bef59",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/syncfusion_flutter_datagrid/assets/font/FilterIcon.ttf": "b8e5e5bf2b490d3576a9562f24395532",
"assets/packages/syncfusion_flutter_datagrid/assets/font/UnsortIcon.ttf": "acdd567faa403388649e37ceb9adeb44",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"flutter_bootstrap.js": "30e1790cee3c789035e876c5871b0ab6",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "f0833d01890c73f957d3dfb2eb9a9a09",
"/": "f0833d01890c73f957d3dfb2eb9a9a09",
"main.dart.js": "7b66663990a7b6a7a550117775073400",
"manifest.json": "849a83c97c6d3c645afaf08c82ff015d",
"version.json": "9d0145322222c4cae0aa2f6bf4402c3b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
