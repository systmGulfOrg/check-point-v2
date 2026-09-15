const fs = require('fs');

function fixIt(file) {
    let code = fs.readFileSync(file, 'utf8');
    code = code.replace(/if \(context\.mounted && success.*\{/g, 'if (context.mounted && success == null) {');
    fs.writeFileSync(file, code);
}

fixIt('lib/features/admin/presentation/screens/admin_request_details_screen.dart');
fixIt('lib/features/admin/presentation/widgets/admin_account_requests_bloc_builder_widget.dart');
