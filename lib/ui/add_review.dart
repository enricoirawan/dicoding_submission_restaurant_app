import 'package:flutter/material.dart';
import 'package:submission_dicoding_app/data/api/api_service.dart';
import 'package:submission_dicoding_app/injection.dart';

class AddReview extends StatefulWidget {
  final String id;
  const AddReview({Key? key, required this.id}) : super(key: key);

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  late FocusNode _namefocusNode;
  late FocusNode _reviewfocusNode;

  @override
  void initState() {
    _namefocusNode = FocusNode();
    _reviewfocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _namefocusNode.dispose();
    _reviewfocusNode.dispose();
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  void _addReview() async {
    final ApiService apiService = getIt<ApiService>();

    if (_formKey.currentState!.validate()) {
      try {
        final bool response = await apiService.addReview(
          widget.id,
          _nameController.text,
          _reviewController.text,
        );

        if (response) {
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Yah, gagal menyimpan review kamu, coba lagi nanti yaa...',
              ),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Yuk Tulis Review Kamu",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
                letterSpacing: 1.2,
              ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _addReview,
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 0.0,
                      blurRadius: 6,
                      offset: const Offset(3.0, 3.0),
                    ),
                    BoxShadow(
                      color: Colors.grey.shade400,
                      spreadRadius: 0.0,
                      blurRadius: 6 / 2.0,
                      offset: const Offset(3.0, 3.0),
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      spreadRadius: 2.0,
                      blurRadius: 6,
                      offset: Offset(-3.0, -3.0),
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      spreadRadius: 2.0,
                      blurRadius: 6 / 2,
                      offset: Offset(-3.0, -3.0),
                    ),
                  ],
                ),
                child: TextFormField(
                  focusNode: _namefocusNode,
                  autofocus: true,
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Nama kamu...",
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama harus diisi yaa...';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 0.0,
                      blurRadius: 6,
                      offset: const Offset(3.0, 3.0),
                    ),
                    BoxShadow(
                      color: Colors.grey.shade400,
                      spreadRadius: 0.0,
                      blurRadius: 6 / 2.0,
                      offset: const Offset(3.0, 3.0),
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      spreadRadius: 2.0,
                      blurRadius: 6,
                      offset: Offset(-3.0, -3.0),
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      spreadRadius: 2.0,
                      blurRadius: 6 / 2,
                      offset: Offset(-3.0, -3.0),
                    ),
                  ],
                ),
                child: TextFormField(
                  focusNode: _reviewfocusNode,
                  controller: _reviewController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Isi review kamu...",
                    prefixIcon: const Icon(Icons.edit),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Isi review harus diisi yaa...';
                    } else if (value.length < 6) {
                      return 'Isi review mu terlalu singkat...';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
