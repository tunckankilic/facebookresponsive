import 'package:facebookresponsive/data/data.dart';
import 'package:facebookresponsive/screens/screens_shelf.dart';
import 'package:facebookresponsive/widgets/widgets_shelf.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const Scaffold(),
    const Scaffold(),
    const Scaffold(),
    const Scaffold(),
    const Scaffold(),
  ];
  final List<IconData> _icons = const [
    Icons.home,
    Icons.ondemand_video,
    MdiIcons.accountCircleOutline,
    MdiIcons.accountGroupOutline,
    MdiIcons.bellOutline,
    Icons.menu,
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    //PageView.builder widget kullanımının Direkt ekran üzerinden yapılmasını sağlayan widget
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        //Ekran kontrolü sonrası yapılacak olan yerleşimin koşulu
        appBar: Responsive.isDesktop(context)
        //AppBar oluşturulması için oluşturulan appbar'ın kapsandığı widget
        //Alternatif olarak normal widget oluşturulurken with PrefferedSize widget'tan miras alabilir
            ? PreferredSize(
                preferredSize: Size(screenSize.width, 100.0),
                child: CustomAppBar(
                  currentUser: currentUser,
                  icons: _icons,
                  selectedIndex: _selectedIndex,
                   onTap: (index) => setState(() => _selectedIndex = index),
                ),
              )
            : null,
            //List[index] kullanımının widget ile daha temiz yazılan versiyonu
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: !Responsive.isDesktop(context)
            ? Container(
                padding: const EdgeInsets.only(bottom: 12.0),
                color: Colors.white,
                //Yapılacak geçiş için iconların içinde bulunduğu liste
                child: CustomTabBar(
                  icons: _icons,
                  selectedIndex: _selectedIndex,
                  onTap: (index) => setState(() => _selectedIndex = index),
                ),
              )
              //Minimum miktarda boşluk sağlar
            : const SizedBox.shrink(),
      ),
    );
  }
}
