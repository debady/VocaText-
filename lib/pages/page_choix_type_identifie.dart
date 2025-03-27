import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:vocatext/routes/routes.dart';

class LoginMethodPage extends StatelessWidget {
  const LoginMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("S'Identifier",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EnterIdentifierPage(type: AuthType.email),
                      ),
                    );
                  },
                  icon: const Icon(Icons.email),
                  label: const Text('Email'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EnterIdentifierPage(type: AuthType.phone),
                      ),
                    );
                  },
                  icon: const Icon(Icons.phone),
                  label: const Text('Téléphone'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('Google'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum AuthType { email, phone }

class EnterIdentifierPage extends StatefulWidget {
  final AuthType type;

  const EnterIdentifierPage({super.key, required this.type});

  @override
  State<EnterIdentifierPage> createState() => _EnterIdentifierPageState();
}

class _EnterIdentifierPageState extends State<EnterIdentifierPage> {
  String? identifier;

  @override
  Widget build(BuildContext context) {
    final isEmail = widget.type == AuthType.email;

    return Scaffold(
      appBar: AppBar(title: Text(isEmail ? 'Email' : 'Téléphone')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            isEmail
                ? TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Adresse email',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => identifier = value,
                  )
                : IntlPhoneField(
                    decoration: const InputDecoration(
                      labelText: 'Numéro de téléphone',
                      border: OutlineInputBorder(),
                    ),
                    initialCountryCode: 'CI',
                    onChanged: (phone) {
                      identifier = phone.completeNumber;
                    },
                  ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (identifier != null && identifier!.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OtpVerificationPage(identifier: identifier!),
                    ),
                  );
                }
              },
              child: const Text('Continuer'),
            ),
          ],
        ),
      ),
    );
  }
}

class OtpVerificationPage extends StatelessWidget {
  final String identifier;

  const OtpVerificationPage({super.key, required this.identifier});

  @override
  Widget build(BuildContext context) {
    final TextEditingController otpController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Vérification OTP')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text('Un code a été envoyé à :',
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text(identifier, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(
                labelText: 'Code OTP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final otp = otpController.text;
                if (otp.length == 4) {
                  // Navigator.pushReplacementNamed(context, '/home');
                  Navigator.pushReplacementNamed(context, AppRoutes.profileSetuppage);
                }
              },
              child: const Text('Vérifier'),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:vocatext/pages/page_accueil.dart';


// class AuthenticationScreen extends StatefulWidget {
//   const AuthenticationScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _AuthenticationScreenState createState() => _AuthenticationScreenState();
// }

// class _AuthenticationScreenState extends State<AuthenticationScreen> {
//   // États de l'écran
//   AuthMethod _currentMethod = AuthMethod.selection;
  
//   // Contrôleurs pour les champs de texte
//   final TextEditingController _identifierController = TextEditingController();
//   final TextEditingController _otpController = TextEditingController();

//   // Liste des codes pays
//   final List<CountryCode> _countryCodes = [
//     CountryCode(code: '+33', name: 'France', flag: '🇫🇷'),
//     CountryCode(code: '+1', name: 'États-Unis', flag: '🇺🇸'),
//     CountryCode(code: '+44', name: 'Royaume-Uni', flag: '🇬🇧'),
//   ];

//   // Code pays sélectionné
//   CountryCode? _selectedCountryCode;

//   // Énumération des méthodes d'authentification
//   enum AuthMethod {
//     selection,
//     emailInput,
//     phoneInput,
//     otpVerification
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: _buildCurrentScreen(),
//         ),
//       ),
//     );
//   }

//   // Construction de l'écran actuel
//   Widget _buildCurrentScreen() {
//     switch (_currentMethod) {
//       case AuthMethod.selection:
//         return _buildMethodSelectionScreen();
//       case AuthMethod.emailInput:
//         return _buildEmailInputScreen();
//       case AuthMethod.phoneInput:
//         return _buildPhoneInputScreen();
//       case AuthMethod.otpVerification:
//         return _buildOtpVerificationScreen();
//     }
//   }

//   // Écran de sélection de la méthode d'authentification
//   Widget _buildMethodSelectionScreen() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(
//           'VocaText',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 32,
//             fontWeight: FontWeight.bold,
//             color: Theme.of(context).primaryColor,
//           ),
//         ),
//         const SizedBox(height: 40),
//         _authMethodButton(
//           icon: Icons.email,
//           text: 'Continuer avec Email',
//           onPressed: () => setState(() {
//             _currentMethod = AuthMethod.emailInput;
//           }),
//         ),
//         const SizedBox(height: 20),
//         _authMethodButton(
//           icon: Icons.phone,
//           text: 'Continuer avec Téléphone',
//           onPressed: () => setState(() {
//             _currentMethod = AuthMethod.phoneInput;
//           }),
//         ),
//         const SizedBox(height: 20),
//         _authMethodButton(
//           icon: Icons.g_translate,
//           text: 'Continuer avec Google',
//           onPressed: _simulateGoogleSignIn,
//           color: Colors.red,
//         ),
//       ],
//     );
//   }

//   // Écran de saisie d'email
//   Widget _buildEmailInputScreen() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         IconButton(
//           alignment: Alignment.centerLeft,
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => setState(() {
//             _currentMethod = AuthMethod.selection;
//           }),
//         ),
//         const SizedBox(height: 20),
//         Text(
//           'Saisissez votre email',
//           style: Theme.of(context).textTheme.headlineSmall,
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 20),
//         TextField(
//           controller: _identifierController,
//           decoration: InputDecoration(
//             hintText: 'votre.email@exemple.com',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           keyboardType: TextInputType.emailAddress,
//         ),
//         const SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: _simulateEmailVerification,
//           child: const Text('Envoyer le code'),
//         ),
//       ],
//     );
//   }

//   // Écran de saisie de numéro de téléphone
//   Widget _buildPhoneInputScreen() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         IconButton(
//           alignment: Alignment.centerLeft,
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => setState(() {
//             _currentMethod = AuthMethod.selection;
//           }),
//         ),
//         const SizedBox(height: 20),
//         Text(
//           'Saisissez votre numéro',
//           style: Theme.of(context).textTheme.headlineSmall,
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 20),
//         Row(
//           children: [
//             // Sélecteur de pays
//             DropdownButton<CountryCode>(
//               value: _selectedCountryCode ?? _countryCodes.first,
//               items: _countryCodes.map((CountryCode country) {
//                 return DropdownMenuItem<CountryCode>(
//                   value: country,
//                   child: Text('${country.flag} ${country.code}'),
//                 );
//               }).toList(),
//               onChanged: (CountryCode? newValue) {
//                 setState(() {
//                   _selectedCountryCode = newValue;
//                 });
//               },
//             ),
//             const SizedBox(width: 10),
//             // Champ de numéro de téléphone
//             Expanded(
//               child: TextField(
//                 controller: _identifierController,
//                 decoration: InputDecoration(
//                   hintText: 'Numéro de téléphone',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 keyboardType: TextInputType.phone,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: _simulatePhoneVerification,
//           child: const Text('Envoyer le code'),
//         ),
//       ],
//     );
//   }

//   // Écran de vérification OTP
//   Widget _buildOtpVerificationScreen() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(
//           'Vérification',
//           style: Theme.of(context).textTheme.headlineSmall,
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 20),
//         Text(
//           'Un code a été envoyé à ${_selectedCountryCode?.code ?? ''} ${_identifierController.text}',
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 20),
//         TextField(
//           controller: _otpController,
//           decoration: InputDecoration(
//             hintText: 'Code de vérification',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           keyboardType: TextInputType.number,
//           maxLength: 6,
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: _simulateOtpVerification,
//           child: const Text('Vérifier'),
//         ),
//         TextButton(
//           onPressed: _simulateResendOtp,
//           child: const Text('Renvoyer le code'),
//         ),
//       ],
//     );
//   }

//   // Bouton de méthode d'authentification
//   Widget _authMethodButton({
//     required IconData icon,
//     required String text,
//     required VoidCallback onPressed,
//     Color? color,
//   }) {
//     return ElevatedButton.icon(
//       icon: Icon(icon),
//       label: Text(text),
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         padding: const EdgeInsets.symmetric(vertical: 15),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }

//   // Simulations de méthodes d'authentification
//   void _simulateGoogleSignIn() {
//     _showSimulationDialog('Simulation de connexion Google');
//   }

//   void _simulateEmailVerification() {
//     setState(() {
//       _currentMethod = AuthMethod.otpVerification;
//     });
//     _showSimulationDialog('Code de vérification envoyé par email');
//   }

//   void _simulatePhoneVerification() {
//     setState(() {
//       _currentMethod = AuthMethod.otpVerification;
//     });
//     _showSimulationDialog('Code de vérification envoyé par SMS');
//   }

//   void _simulateOtpVerification() {
//     if (_otpController.text == '123456') {
//       // OTP correct
//       _showSuccessDialog('Authentification réussie');
//     } else {
//       _showSimulationDialog('Code OTP incorrect');
//     }
//   }

//   void _simulateResendOtp() {
//     _showSimulationDialog('Nouveau code OTP envoyé');
//   }

//   // Boîte de dialogue de simulation
//   void _showSimulationDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Simulation'),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   // Boîte de dialogue de succès
//   void _showSuccessDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Succès'),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               // Naviguer vers l'écran principal
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (_) => HomeScreen()),
//               );
//             },
//             child: const Text('Continuer'),
//           ),
//         ],
//       ),
//     );
//   }
// }



// // Classe pour représenter les codes pays
// class CountryCode {
//   final String code;
//   final String name;
//   final String flag;

//   CountryCode({
//     required this.code,
//     required this.name,
//     required this.flag,
//   });
// }