import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

/// Prompts the user with a dialog to rename an uploaded file before saving.
/// Returns the chosen filename (including extension), or null if the user canceled the upload.
Future<String?> showRenameFileDialog(BuildContext context, String originalPath) async {
  final originalBasename = p.basename(originalPath);
  final ext = p.extension(originalPath);
  final nameWithoutExt = p.basenameWithoutExtension(originalPath);

  final controller = TextEditingController(text: nameWithoutExt);
  final formKey = GlobalKey<FormState>();

  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: const [
            Icon(Icons.edit_note, color: Colors.blue),
            SizedBox(width: 8),
            Text('Rename Attachment'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Original File: $originalBasename',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'File Name',
                  suffixText: ext,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.insert_drive_file_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'File name cannot be empty';
                  }
                  final invalidChars = RegExp(r'[\\/:*?"<>|]');
                  if (invalidChars.hasMatch(value)) {
                    return r'Filename contains invalid characters (\ / : * ? " < > |)';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text('Cancel Upload', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton.icon(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final newName = controller.text.trim();
                final finalFileName = ext.isNotEmpty ? '$newName$ext' : newName;
                Navigator.pop(context, finalFileName);
              }
            },
            icon: const Icon(Icons.check, size: 18),
            label: const Text('Use Name'),
          ),
        ],
      );
    },
  );
}
