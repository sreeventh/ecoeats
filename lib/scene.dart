import 'package:flutter/material.dart';
import 'utils.dart';
import 'LoginPage.dart';

class Scene extends StatelessWidget {
  const Scene({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // iphone14promax1hKo (1:11)
        width: double.infinity,
        height: 932 * fem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(37 * fem),
          gradient: const LinearGradient(
            begin: Alignment(0, -1.238),
            end: Alignment(-0.079, 1.826),
            colors: <Color>[
              Color(0x68b9d6b4),
              Color(0xf64ab161),
              Color(0xff10c217),
              Color(0x00f4f8fd)
            ],
            stops: <double>[0, 0.416, 0.807, 1],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0x3f000000),
              offset: Offset(0 * fem, 4 * fem),
              blurRadius: 2 * fem,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              // autogroupdwqw1dK (73ssVTLDhHeYPufz3XDWQw)
              left: 48 * fem,
              top: 558 * fem,
              child: Container(
                width: 333 * fem,
                height: 60 * fem,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55 * fem),
                  gradient: const LinearGradient(
                    begin: Alignment(-1.865, -0),
                    end: Alignment(1.508, -0),
                    colors: <Color>[Color(0xff5d75ca), Color(0x002c7ac2)],
                    stops: <double>[0, 1],
                  ),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: Text(
                      'Login',
                      style: SafeGoogleFont('Poppins',
                          fontSize: 24 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.5 * ffem / fem,
                          color: const Color(0xffffffff),
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // autogroupj2phxgy (73ssdHSWNRUiAiXepfj2PH)
              left: 49 * fem,
              top: 669 * fem,
              child: Container(
                width: 333 * fem,
                height: 60 * fem,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55 * fem),
                  gradient: const LinearGradient(
                    begin: Alignment(-1.865, -0),
                    end: Alignment(1.508, -0),
                    colors: <Color>[Color(0xff5d75ca), Color(0x002c7ac2)],
                    stops: <double>[0, 1],
                  ),
                ),
                child: Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 24 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.5 * ffem / fem,
                        color: const Color(0xffffffff),
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ),
            Positioned(
              // screenshot20230923at6441ksj (118:5)
              left: 120 * fem,
              top: 169 * fem,
              child: Container(
                width: 225 * fem,
                height: 223 * fem,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/logo__1_-removebg-preview.png',
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // ecoeatswhK (1:32)
              left: 87 * fem,
              top: 410 * fem,
              child: Align(
                child: SizedBox(
                  width: 258 * fem,
                  height: 85 * fem,
                  child: Text('Eco Eats',
                      style: TextStyle(
                          fontSize: 50 * ffem,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          decoration: TextDecoration.none)),
                ),
              ),
            ),
            Positioned(
              // goodearthgoodfoodgoodyouDeq (102:11)
              left: 67 * fem,
              top: 792 * fem,
              child: SizedBox(
                width: 298 * fem,
                height: 36 * fem,
              ),
            ),
            Positioned(
              // goodearthgoodfoodgoodyouw53 (1:33)
              left: 66 * fem,
              top: 804 * fem,
              child: Align(
                child: SizedBox(
                  width: 298 * fem,
                  height: 36 * fem,
                  child: Text(
                    'Good Earth, Good Food, Good You',
                    style: TextStyle(
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffffffff),
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
