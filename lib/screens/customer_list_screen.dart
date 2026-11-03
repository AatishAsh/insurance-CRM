import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/customer_provider.dart';
import '../models/customer.dart';
import '../theme/app_colors.dart';
import '../widgets/color_badge.dart';
import 'customer_form_screen.dart';
import 'customer_detail_screen.dart';
import '../services/app_storage_service.dart';

class CustomerDocumentResult {
  final Customer customer;
  final CustomerDocument document;

  CustomerDocumentResult({required this.customer, required this.document});
}

class CustomerListScreen extends ConsumerStatefulWidget {
  const CustomerListScreen({super.key});

  @override
  ConsumerState<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends ConsumerState<CustomerListScreen> {
  String? _localDocsDirPath;
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: ref.read(searchQueryProvider));
    _searchFocusNode = FocusNode();
    _initLocalDocsDirPath();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _initLocalDocsDirPath() async {
    final docsDir = await AppStorageService.getCustomerDocumentsDirectory();
    setState(() {
      _localDocsDirPath = docsDir.path;
    });
  }

  void _previewDocument(BuildContext context, CustomerDocument doc) {
    if (doc.fileName == null || doc.fileName!.isEmpty || _localDocsDirPath == null) return;
    final file = File('$_localDocsDirPath/${doc.fileName}');
    
    if (!file.existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Document file not found on this device')),
      );
      return;
    }

    final isImage = ['.jpg', '.jpeg', '.png', '.gif', '.webp']
        .any((ext) => doc.fileName!.toLowerCase().endsWith(ext));

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.cardBorder),
              boxShadow: const [AppColors.cardShadow],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: Text(
                    doc.documentName ?? doc.fileName ?? 'Document Preview',
                    style: const TextStyle(fontSize: 16, color: AppColors.headingText, fontWeight: FontWeight.bold),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.close, color: AppColors.headingText),
                    onPressed: () => Navigator.pop(context),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                const SizedBox(height: 8),
                if (isImage)
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 450),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: InteractiveViewer(
                        panEnabled: true,
                        minScale: 1.0,
                        maxScale: 5.0,
                        child: Image.file(
                          file,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.insert_drive_file, size: 64, color: AppColors.skyBlue),
                        const SizedBox(height: 12),
                        Text(
                          doc.fileName ?? 'Document File',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.headingText),
                          textAlign: TextAlign.center,
                        ),
                        if (doc.documentName != null) ...[
                          const SizedBox(height: 8),
                          ColorBadge(
                            text: 'Type/Label: ${doc.documentName}',
                            style: BadgeStyle.blue,
                          ),
                        ],
                        const SizedBox(height: 8),
                        const Text(
                          'Document file saved on device',
                          style: TextStyle(color: AppColors.mutedText, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  List<CustomerDocumentResult> _getMatchingDocuments(List<Customer> customers, String searchQuery) {
    final query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) return [];

    final keywords = query.split(' ').where((k) => k.isNotEmpty).toList();
    final List<CustomerDocumentResult> results = [];

    for (final customer in customers) {
      for (final doc in customer.documents) {
        final custNameMatch = customer.name.toLowerCase().contains(query);
        final docNameMatch = doc.documentName?.toLowerCase().contains(query) ?? false;
        final fileNameMatch = doc.fileName?.toLowerCase().contains(query) ?? false;

        final keywordMatch = keywords.every((k) =>
          customer.name.toLowerCase().contains(k) ||
          (doc.documentName?.toLowerCase().contains(k) ?? false) ||
          (doc.fileName?.toLowerCase().contains(k) ?? false) ||
          (customer.customerId?.toLowerCase().contains(k) ?? false) ||
          (customer.familyId?.toLowerCase().contains(k) ?? false) ||
          (customer.mobileNumber1?.toLowerCase().contains(k) ?? false) ||
          (customer.mobileNumber2?.toLowerCase().contains(k) ?? false) ||
          (customer.mobileNumber3?.toLowerCase().contains(k) ?? false) ||
          (customer.mobileNumber4?.toLowerCase().contains(k) ?? false) ||
          (customer.officeContactNumber?.toLowerCase().contains(k) ?? false)
        );

        if (custNameMatch || docNameMatch || fileNameMatch || keywordMatch) {
          results.add(CustomerDocumentResult(customer: customer, document: doc));
        }
      }
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(customerListProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final selectedTab = ref.watch(customerSearchTabProvider);
    final bool isSearching = searchQuery.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Customer Directory'),
        backgroundColor: AppColors.cardSurface,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 12.0),
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _searchController,
              builder: (context, value, child) {
                return TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChanged: (text) {
                    ref.read(searchQueryProvider.notifier).state = text;
                    ref.read(customerPageProvider.notifier).state = 0;
                  },
                  decoration: InputDecoration(
                    hintText: 'Search by Name, Family ID, Phone, ID, Document...',
                    hintStyle: const TextStyle(fontSize: 13.5, color: AppColors.mutedText),
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.skyBlue),
                    suffixIcon: value.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, color: AppColors.mutedText, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              ref.read(searchQueryProvider.notifier).state = '';
                              ref.read(customerPageProvider.notifier).state = 0;
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: AppColors.cardSurface,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppColors.cardBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppColors.cardBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppColors.skyBlue, width: 1.5),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: customersAsync.when(
        data: (customers) {
          final docResults = _getMatchingDocuments(customers, searchQuery);

          if (customers.isEmpty && docResults.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.people_outline, size: 64, color: AppColors.mutedText),
                  const SizedBox(height: 16),
                  Text(
                    searchQuery.isEmpty ? 'No customers found. Add your first customer!' : 'No results matching "$searchQuery"',
                    style: const TextStyle(color: AppColors.bodyText, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }

          // Determine what items to display based on selectedTab ('All', 'Profiles', 'Documents')
          final bool showProfiles = !isSearching || selectedTab == 'All' || selectedTab == 'Profiles';
          final bool showDocs = isSearching && (selectedTab == 'All' || selectedTab == 'Documents');

          return Column(
            children: [
              // Search Filter Tabs Header (Only shown when user is actively searching)
              if (isSearching) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: AppColors.appBackgroundAlt,
                  child: Row(
                    children: [
                      FilterChip(
                        selected: selectedTab == 'All',
                        selectedColor: AppColors.badgeBlueBg,
                        label: Text('All (${customers.length + docResults.length})', style: TextStyle(color: selectedTab == 'All' ? AppColors.skyBlue : AppColors.bodyText, fontWeight: FontWeight.bold)),
                        onSelected: (_) => ref.read(customerSearchTabProvider.notifier).state = 'All',
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        selected: selectedTab == 'Profiles',
                        selectedColor: AppColors.badgeBlueBg,
                        label: Text('Profiles (${customers.length})', style: TextStyle(color: selectedTab == 'Profiles' ? AppColors.skyBlue : AppColors.bodyText, fontWeight: FontWeight.bold)),
                        onSelected: (_) => ref.read(customerSearchTabProvider.notifier).state = 'Profiles',
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        selected: selectedTab == 'Documents',
                        selectedColor: AppColors.badgeBlueBg,
                        label: Text('Documents (${docResults.length})', style: TextStyle(color: selectedTab == 'Documents' ? AppColors.skyBlue : AppColors.bodyText, fontWeight: FontWeight.bold)),
                        avatar: const Icon(Icons.attach_file, size: 16, color: AppColors.skyBlue),
                        onSelected: (_) => ref.read(customerSearchTabProvider.notifier).state = 'Documents',
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
              ],
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Document Result Cards Section (shown in 'All' or 'Documents' tab)
                      if (showDocs && docResults.isNotEmpty) ...[
                        if (selectedTab == 'All') ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0, left: 4),
                            child: Row(
                              children: [
                                const Icon(Icons.description_outlined, size: 18, color: AppColors.skyBlue),
                                const SizedBox(width: 6),
                                Text(
                                  'Matching Document Results (${docResults.length}):',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.skyBlue),
                                ),
                              ],
                            ),
                          ),
                        ],
                        ...docResults.map((result) => _buildDocumentTile(context, ref, result)),
                      ],

                      // Customer Profiles Section (shown in 'All' or 'Profiles' tab)
                      if (showProfiles && customers.isNotEmpty) ...[
                        if (selectedTab == 'All' && docResults.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0, left: 4),
                            child: Row(
                              children: [
                                const Icon(Icons.person_outline, size: 18, color: AppColors.headingText),
                                const SizedBox(width: 6),
                                Text(
                                  'Customer Profiles (${customers.length}):',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.headingText),
                                ),
                              ],
                            ),
                          ),
                        ],
                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth > 700) {
                              final int cols = constraints.maxWidth > 1150 ? 3 : 2;
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: cols,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  mainAxisExtent: 140,
                                ),
                                itemCount: customers.length,
                                itemBuilder: (context, index) {
                                  return _buildCustomerTile(context, ref, customers[index], searchQuery, isGridItem: true);
                                },
                              );
                            }
                            return Column(
                              children: customers.map((cust) => _buildCustomerTile(context, ref, cust, searchQuery)).toList(),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.skyBlue)),
        error: (err, stack) => Center(child: Text('Error loading customers: $err', style: const TextStyle(color: AppColors.roseAccent))),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.skyBlue,
        foregroundColor: Colors.white,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CustomerFormScreen()),
          );
          // Refresh list and reset page to 0 on adding new customer
          ref.read(customerPageProvider.notifier).state = 0;
          ref.invalidate(customerListProvider);
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Add Customer', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildDocumentTile(BuildContext context, WidgetRef ref, CustomerDocumentResult result) {
    final customer = result.customer;
    final doc = result.document;
    final String docTitle = "${customer.name}'s ${doc.documentName ?? 'Document'}";
    final String fileName = doc.fileName ?? '';
    final File? docFile = _localDocsDirPath != null && fileName.isNotEmpty
        ? File('$_localDocsDirPath/$fileName')
        : null;

    final isImg = ['.jpg', '.jpeg', '.png', '.gif', '.webp']
        .any((ext) => fileName.toLowerCase().endsWith(ext));

    final int hash = customer.name.hashCode;
    final List<Color> colors = [Colors.blue, Colors.purple, Colors.teal, Colors.orange, Colors.indigo, Colors.pink, Colors.red, Colors.green];
    final color = colors[hash.abs() % colors.length];

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: isImg ? Colors.blue.withOpacity(0.3) : Colors.purple.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _previewDocument(context, doc),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: Neat 60x60 Thumbnail
              GestureDetector(
                onTap: () => _previewDocument(context, doc),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isImg ? Colors.blue.withOpacity(0.08) : Colors.purple.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: isImg ? Colors.blue.withOpacity(0.3) : Colors.purple.withOpacity(0.3)),
                    ),
                    child: isImg && docFile != null && docFile.existsSync()
                        ? Image.file(
                            docFile,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Icon(Icons.image, size: 28, color: Colors.blue[400]),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isImg ? Icons.image : Icons.insert_drive_file,
                                color: isImg ? Colors.blue[700] : Colors.purple[700],
                                size: 24,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                fileName.contains('.') ? fileName.split('.').last.toUpperCase() : 'DOC',
                                style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: isImg ? Colors.blue[900] : Colors.purple[900]),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Center Details: Title, File Name, Customer Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            docTitle,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            doc.documentName ?? 'Document',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue[800]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'File: $fileName',
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: color.withOpacity(0.2),
                          child: Text(
                            customer.name.isNotEmpty ? customer.name[0].toUpperCase() : '?',
                            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Owner: ${customer.name} (${customer.customerId ?? 'No ID'})',
                            style: TextStyle(color: Colors.grey[600], fontSize: 11),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Right Actions: Preview Button + Profile Link
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _previewDocument(context, doc),
                    icon: const Icon(Icons.visibility, size: 14),
                    label: const Text('View', style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      minimumSize: const Size(64, 32),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CustomerDetailScreen(customerId: customer.id),
                        ),
                      );
                      ref.invalidate(customerListProvider);
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.person_outline, size: 13, color: Colors.grey[700]),
                          const SizedBox(width: 2),
                          Text('Profile', style: TextStyle(fontSize: 11, color: Colors.grey[800])),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerTile(BuildContext context, WidgetRef ref, Customer customer, String searchQuery, {bool isGridItem = false}) {
    // Generate a unique avatar color based on the hash of the customer's name
    final int hash = customer.name.hashCode;
    final List<Color> colors = [Colors.blue, Colors.purple, Colors.teal, Colors.orange, Colors.indigo, Colors.pink, Colors.red, Colors.green];
    final color = colors[hash.abs() % colors.length];

    final String policyInfo = customer.selfPolicyNumber != null && customer.selfPolicyNumber!.isNotEmpty
        ? 'Policy: ${customer.selfPolicyNumber}'
        : 'No Active Policy';

    final String queryLower = searchQuery.toLowerCase().trim();
    final bool hasSearchQuery = queryLower.isNotEmpty;

    bool isDocMatch(CustomerDocument doc) {
      if (!hasSearchQuery) return false;
      final labelMatch = doc.documentName?.toLowerCase().contains(queryLower) ?? false;
      final fileMatch = doc.fileName?.toLowerCase().contains(queryLower) ?? false;
      return labelMatch || fileMatch;
    }

    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: isGridItem ? 0 : 12.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CustomerDetailScreen(customerId: customer.id),
            ),
          );
          ref.invalidate(customerListProvider);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: color.withOpacity(0.15),
                    child: Text(
                      customer.name.isNotEmpty ? customer.name[0].toUpperCase() : '?',
                      style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(customer.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(
                          'ID: ${customer.customerId ?? 'CUST-${customer.id}'}${customer.familyId != null && customer.familyId!.isNotEmpty ? '  •  Fam: ${customer.familyId}' : ''}  •  ${customer.mobileNumber1 ?? 'No Phone'}',
                          style: TextStyle(color: Colors.grey[700], fontSize: 13),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          policyInfo,
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, size: 20, color: Colors.blue),
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CustomerFormScreen(customer: customer),
                        ),
                      );
                      ref.invalidate(customerListProvider);
                    },
                  ),
                ],
              ),
              if (hasSearchQuery && customer.documents.isNotEmpty) ...[
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.folder_open_outlined, size: 14, color: Colors.grey[700]),
                    const SizedBox(width: 6),
                    Text(
                      'Uploaded Documents (${customer.documents.length}):',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: customer.documents.map((doc) {
                    final matched = isDocMatch(doc);
                    final String label = doc.documentName ?? 'Document';
                    final String fileName = doc.fileName ?? '';
                    final isImg = ['.jpg', '.jpeg', '.png', '.gif', '.webp']
                        .any((ext) => fileName.toLowerCase().endsWith(ext));

                    final chipBg = matched
                        ? Colors.amber[100]
                        : (isImg ? Colors.blue.withOpacity(0.08) : Colors.purple.withOpacity(0.08));
                    final chipBorder = matched
                        ? Colors.amber[700]!
                        : (isImg ? Colors.blue.withOpacity(0.3) : Colors.purple.withOpacity(0.3));
                    final textColor = matched
                        ? Colors.amber[900]!
                        : (isImg ? Colors.blue[900]! : Colors.purple[900]!);

                    String displayText = label;
                    if (fileName.isNotEmpty && fileName.toLowerCase() != label.toLowerCase()) {
                      displayText += ' ($fileName)';
                    }

                    return InkWell(
                      onTap: () => _previewDocument(context, doc),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: chipBg,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: chipBorder, width: matched ? 1.5 : 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isImg ? Icons.image_outlined : Icons.insert_drive_file_outlined,
                              size: 14,
                              color: textColor,
                            ),
                            const SizedBox(width: 4),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 220),
                              child: Text(
                                displayText,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: matched ? FontWeight.bold : FontWeight.w600,
                                  color: textColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
