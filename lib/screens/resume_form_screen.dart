import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:resumemaker/bloc/resume_bloc.dart';
import 'package:resumemaker/bloc/resume_event.dart';
import 'package:resumemaker/utilities/app_localizations.dart';
import 'package:resumemaker/utilities/models.dart';
import 'package:resumemaker/service/pdf_service.dart';

class ResumeFormScreen extends StatefulWidget {
  final Resume? resume;

  const ResumeFormScreen({super.key, this.resume});

  @override
  State<ResumeFormScreen> createState() => _ResumeFormScreenState();
}

class _ResumeFormScreenState extends State<ResumeFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _fullNameController;
  late TextEditingController _contactController;
  late TextEditingController _addressController;
  late TextEditingController _linkedinController;
  late TextEditingController _websiteController;
  late TextEditingController _descriptionController;
  late TextEditingController _emailController;
  late TextEditingController _attachmentController;

  List<Education> _educations = [];
  List<Experience> _experiences = [];
  List<Skill> _skills = [];
  List<Certificate> _certificates = [];
  bool _isFresher = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(
      text: widget.resume?.fullName ?? '',
    );
    _contactController = TextEditingController(
      text: widget.resume?.contact ?? '',
    );
    _addressController = TextEditingController(
      text: widget.resume?.address ?? '',
    );
    _linkedinController = TextEditingController(
      text: widget.resume?.linkedin ?? '',
    );
    _websiteController = TextEditingController(
      text: widget.resume?.website ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.resume?.description ?? '',
    );
    _emailController = TextEditingController(text: widget.resume?.email ?? '');
    _attachmentController = TextEditingController(
      text: widget.resume?.attachment ?? '',
    );

    if (widget.resume != null) {
      _isFresher = widget.resume!.isFresher;
      _educations = List.from(widget.resume!.education);
      _experiences = List.from(widget.resume!.experience);
      _skills = List.from(widget.resume!.skills);
      _certificates = List.from(widget.resume!.certificates);
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _contactController.dispose();
    _addressController.dispose();
    _linkedinController.dispose();
    _websiteController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    _attachmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.resume == null
              ? localizations.translate('create_resume')
              : localizations.translate('edit'),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: localizations.translate('full_name'),
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.translate('fill_required_fields');
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contactController,
              decoration: InputDecoration(
                labelText: localizations.translate('contact'),
                prefixIcon: const Icon(Icons.phone),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.translate('fill_required_fields');
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: localizations.translate('address'),
                prefixIcon: const Icon(Icons.location_on),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.translate('fill_required_fields');
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: localizations.translate('email'),
                prefixIcon: const Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.translate('email_required');
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _linkedinController,
              decoration: InputDecoration(
                labelText: localizations.translate('linkedin'),
                prefixIcon: const Icon(Icons.link),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.translate('linkedin_required');
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _websiteController,
              decoration: InputDecoration(
                labelText: localizations.translate('website'),
                prefixIcon: const Icon(Icons.language),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: localizations.translate('description'),
                prefixIcon: const Icon(Icons.description),
                helperText: 'Max 100 characters',
              ),
              maxLines: 4,
              maxLength: 100,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.translate('fill_required_fields');
                }
                if (value.length > 100) {
                  return localizations.translate('description_limit');
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _attachmentController,
              decoration: InputDecoration(
                labelText: localizations.translate('attachment'),
                prefixIcon: const Icon(Icons.attach_file),
              ),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: Text(localizations.translate('fresher')),
              value: _isFresher,
              onChanged: (value) {
                setState(() {
                  _isFresher = value ?? false;
                });
              },
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),
            _buildSectionHeader(localizations.translate('education'), () {
              _addEducation();
            }),
            ..._educations.asMap().entries.map((entry) {
              return _buildEducationCard(entry.key, entry.value, localizations);
            }),
            const SizedBox(height: 24),
            _buildSectionHeader(localizations.translate('experience'), () {
              _addExperience();
            }),
            ..._experiences.asMap().entries.map((entry) {
              return _buildExperienceCard(
                entry.key,
                entry.value,
                localizations,
              );
            }),
            const SizedBox(height: 24),
            _buildSectionHeader(localizations.translate('skills'), () {
              _addSkill();
            }),
            ..._skills.asMap().entries.map((entry) {
              return _buildSkillCard(entry.key, entry.value, localizations);
            }),
            const SizedBox(height: 24),
            _buildSectionHeader(localizations.translate('certificates'), () {
              _addCertificate();
            }),
            ..._certificates.asMap().entries.map((entry) {
              return _buildCertificateCard(
                entry.key,
                entry.value,
                localizations,
              );
            }),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _saveResume,
                    icon: const Icon(Icons.save),
                    label: Text(localizations.translate('save')),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _createPdf,
                    icon: const Icon(Icons.picture_as_pdf),
                    label: Text(localizations.translate('create_pdf')),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onAdd) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        IconButton(
          onPressed: onAdd,
          icon: const Icon(Icons.add_circle),
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  Widget _buildEducationCard(
    int index,
    Education education,
    AppLocalizations localizations,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${localizations.translate('education')} ${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _educations.removeAt(index);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: education.institution,
              decoration: InputDecoration(
                labelText: localizations.translate('institution'),
              ),
              onChanged: (value) => education.institution = value,
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: education.degree,
              decoration: InputDecoration(
                labelText: localizations.translate('degree'),
              ),
              onChanged: (value) => education.degree = value,
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: education.fieldOfStudy,
              decoration: InputDecoration(
                labelText: localizations.translate('field_of_study'),
              ),
              onChanged: (value) => education.fieldOfStudy = value,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: education.startDate,
                    decoration: InputDecoration(
                      labelText: localizations.translate('start_date'),
                    ),
                    onChanged: (value) => education.startDate = value,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    initialValue: education.endDate,
                    decoration: InputDecoration(
                      labelText: localizations.translate('end_date'),
                    ),
                    onChanged: (value) => education.endDate = value,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: education.grade,
              decoration: InputDecoration(
                labelText: localizations.translate('grade'),
              ),
              onChanged: (value) => education.grade = value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceCard(
    int index,
    Experience experience,
    AppLocalizations localizations,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${localizations.translate('experience')} ${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _experiences.removeAt(index);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: experience.company,
              decoration: InputDecoration(
                labelText: localizations.translate('company'),
              ),
              onChanged: (value) => experience.company = value,
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: experience.position,
              decoration: InputDecoration(
                labelText: localizations.translate('position'),
              ),
              onChanged: (value) => experience.position = value,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: experience.startDate,
                    decoration: InputDecoration(
                      labelText: localizations.translate('start_date'),
                    ),
                    onChanged: (value) => experience.startDate = value,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    initialValue: experience.endDate,
                    decoration: InputDecoration(
                      labelText: localizations.translate('end_date'),
                    ),
                    onChanged: (value) => experience.endDate = value,
                    enabled: !experience.currentlyWorking,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              title: Text(localizations.translate('currently_working')),
              value: experience.currentlyWorking,
              onChanged: (value) {
                setState(() {
                  experience.currentlyWorking = value ?? false;
                });
              },
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: experience.description,
              decoration: InputDecoration(
                labelText: localizations.translate('description'),
              ),
              maxLines: 3,
              onChanged: (value) => experience.description = value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillCard(
    int index,
    Skill skill,
    AppLocalizations localizations,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                initialValue: skill.name,
                decoration: InputDecoration(
                  labelText: localizations.translate('skill_name'),
                ),
                onChanged: (value) => skill.name = value,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: skill.level,
                decoration: InputDecoration(
                  labelText: localizations.translate('skill_level'),
                ),
                items:
                    ['Beginner', 'Intermediate', 'Advanced', 'Expert']
                        .map(
                          (level) => DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    skill.level = value ?? 'Intermediate';
                  });
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  _skills.removeAt(index);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificateCard(
    int index,
    Certificate certificate,
    AppLocalizations localizations,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${localizations.translate('certificates')} ${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _certificates.removeAt(index);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: certificate.name,
              decoration: InputDecoration(
                labelText: localizations.translate('certificate_name'),
              ),
              onChanged: (value) => certificate.name = value,
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: certificate.issuer,
              decoration: InputDecoration(
                labelText: localizations.translate('issuer'),
              ),
              onChanged: (value) => certificate.issuer = value,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: certificate.date,
                    decoration: InputDecoration(
                      labelText: localizations.translate('date'),
                    ),
                    onChanged: (value) => certificate.date = value,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    initialValue: certificate.credentialId,
                    decoration: InputDecoration(
                      labelText: localizations.translate('credential_id'),
                    ),
                    onChanged: (value) => certificate.credentialId = value,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addEducation() {
    setState(() {
      _educations.add(
        Education(
          institution: '',
          degree: '',
          fieldOfStudy: '',
          startDate: '',
          endDate: '',
        ),
      );
    });
  }

  void _addExperience() {
    setState(() {
      _experiences.add(
        Experience(
          company: '',
          position: '',
          startDate: '',
          endDate: '',
          description: '',
        ),
      );
    });
  }

  void _addSkill() {
    setState(() {
      _skills.add(Skill(name: ''));
    });
  }

  void _addCertificate() {
    setState(() {
      _certificates.add(Certificate(name: '', issuer: '', date: ''));
    });
  }

  void _saveResume() {
    final localizations = AppLocalizations.of(context);

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_educations.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.translate('education_required'))),
      );
      return;
    }

    if (!_isFresher && _experiences.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.translate('experience_required'))),
      );
      return;
    }

    if (_skills.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.translate('skills_required'))),
      );
      return;
    }

    final resume = Resume(
      id: widget.resume?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: _fullNameController.text,
      contact: _contactController.text,
      address: _addressController.text,
      linkedin: _linkedinController.text,
      website: _websiteController.text,
      description: _descriptionController.text,
      education: _educations,
      experience: _experiences,
      skills: _skills,
      certificates: _certificates,
      createdAt: widget.resume?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
      email: _emailController.text,
      attachment: _attachmentController.text,
      isFresher: _isFresher,
    );

    if (widget.resume == null) {
      context.read<ResumeBloc>().add(AddResume(resume));
    } else {
      context.read<ResumeBloc>().add(UpdateResume(resume));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).translate('resume_saved')),
      ),
    );

    Navigator.pop(context);
  }

  void _createPdf() async {
    final localizations = AppLocalizations.of(context);

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_educations.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.translate('education_required'))),
      );
      return;
    }

    if (!_isFresher && _experiences.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.translate('experience_required'))),
      );
      return;
    }

    if (_skills.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.translate('skills_required'))),
      );
      return;
    }

    final templateType = await showDialog<int>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(localizations.translate('select_template')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(localizations.translate('template_basic')),
                  leading: const Icon(Icons.description),
                  onTap: () => Navigator.pop(context, 1),
                ),
                ListTile(
                  title: Text(localizations.translate('template_classic')),
                  leading: const Icon(Icons.article),
                  onTap: () => Navigator.pop(context, 2),
                ),
                ListTile(
                  title: Text(localizations.translate('template_modern')),
                  leading: const Icon(Icons.auto_awesome),
                  onTap: () => Navigator.pop(context, 3),
                ),
              ],
            ),
          ),
    );

    if (templateType != null) {
      PdfColor? selectedColor;

      // Show color picker for Classic and Modern templates
      if (templateType == 2 || templateType == 3) {
        selectedColor = await _showColorPicker(context, localizations);
        if (selectedColor == null) return; // User cancelled color selection
      }
      final resume = Resume(
        id:
            widget.resume?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        fullName: _fullNameController.text,
        contact: _contactController.text,
        address: _addressController.text,
        linkedin: _linkedinController.text,
        website: _websiteController.text,
        description: _descriptionController.text,
        education: _educations,
        experience: _experiences,
        skills: _skills,
        certificates: _certificates,
        createdAt: widget.resume?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        email: _emailController.text,
        attachment: _attachmentController.text,
        isFresher: _isFresher,
      );

      try {
        final filePath = await PdfService.generatePdf(
          resume,
          templateType,
          selectedColor: selectedColor,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${localizations.translate('pdf_created')}: $filePath',
              ),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${localizations.translate('error')}: $e')),
          );
        }
      }
    }
  }

  Future<PdfColor?> _showColorPicker(
    BuildContext context,
    AppLocalizations localizations,
  ) async {
    final colors = {
      'Blue': PdfColors.blue,
      'Red': PdfColors.red,
      'Green': PdfColors.green,
      'Orange': PdfColors.orange,
      'Purple': PdfColors.purple,
      'Teal': PdfColors.teal,
      'Pink': PdfColors.pink,
      'Indigo': PdfColors.indigo,
    };

    return await showDialog<PdfColor>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(localizations.translate('select_color')),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:
                    colors.entries.map((entry) {
                      return ListTile(
                        leading: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(
                              255,
                              (entry.value.red * 255).toInt(),
                              (entry.value.green * 255).toInt(),
                              (entry.value.blue * 255).toInt(),
                            ),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        title: Text(entry.key),
                        onTap: () => Navigator.pop(context, entry.value),
                      );
                    }).toList(),
              ),
            ),
          ),
    );
  }
}
