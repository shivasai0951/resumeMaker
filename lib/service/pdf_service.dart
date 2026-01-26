import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:resumemaker/utilities/models.dart';

class PdfService {
  static Future<String> generatePdf(
    Resume resume,
    int templateType, {
    PdfColor? selectedColor,
  }) async {
    final pdf = pw.Document();

    switch (templateType) {
      case 1:
        _addBasicTemplate(pdf, resume);
        break;
      case 2:
        _addClassicTemplate(pdf, resume, selectedColor ?? PdfColors.blue);
        break;
      case 3:
        _addModernTemplate(pdf, resume, selectedColor ?? PdfColors.teal);
        break;
      default:
        _addBasicTemplate(pdf, resume);
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${resume.fullName}_resume.pdf');
    await file.writeAsBytes(await pdf.save());

    return file.path;
  }

  // Template 1: Basic - Clean white layout with underlined sections
  static void _addBasicTemplate(pw.Document pdf, Resume resume) {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        theme: pw.ThemeData.withFont(
          base: pw.Font.times(),
          bold: pw.Font.timesBold(),
        ),
        build:
            (context) => [
              // Name - Big and centered
              pw.Center(
                child: pw.Text(
                  resume.fullName.toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 28,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 8),

              // Contact info in one line
              pw.Center(
                child: pw.Text(
                  [
                    resume.email,
                    resume.contact,
                    resume.linkedin,
                    if (resume.website.isNotEmpty) resume.website,
                  ].join(' | '),
                  style: const pw.TextStyle(fontSize: 11),
                ),
              ),
              pw.SizedBox(height: 4),

              // Address
              pw.Center(
                child: pw.Text(
                  resume.address,
                  style: const pw.TextStyle(fontSize: 11),
                ),
              ),
              pw.SizedBox(height: 20),

              // Description section
              pw.Container(
                decoration: const pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: 1)),
                ),
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Text(
                  'PROFESSIONAL SUMMARY',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                resume.description,
                style: const pw.TextStyle(fontSize: 11),
              ),
              pw.SizedBox(height: 16),

              // Experience section
              if (resume.experience.isNotEmpty) ...[
                pw.Container(
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: 1)),
                  ),
                  padding: const pw.EdgeInsets.only(bottom: 4),
                  child: pw.Text(
                    'EXPERIENCE',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),
                ...resume.experience.map(
                  (exp) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 12),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          exp.position,
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          '${exp.company} | ${exp.startDate} - ${exp.currentlyWorking ? "Present" : exp.endDate}',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          exp.description,
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 16),
              ],

              // Skills section
              pw.Container(
                decoration: const pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: 1)),
                ),
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Text(
                  'SKILLS',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                resume.skills.map((s) => s.name).join(' • '),
                style: const pw.TextStyle(fontSize: 11),
              ),
              pw.SizedBox(height: 16),

              // Education section
              pw.Container(
                decoration: const pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: 1)),
                ),
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Text(
                  'EDUCATION',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 8),
              ...resume.education.map(
                (edu) => pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 10),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        '${edu.degree} in ${edu.fieldOfStudy}',
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        '${edu.institution} | ${edu.startDate} - ${edu.endDate}',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                      if (edu.grade.isNotEmpty)
                        pw.Text(
                          'Grade: ${edu.grade}',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                    ],
                  ),
                ),
              ),

              // Certificates section
              if (resume.certificates.isNotEmpty) ...[
                pw.SizedBox(height: 16),
                pw.Container(
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: 1)),
                  ),
                  padding: const pw.EdgeInsets.only(bottom: 4),
                  child: pw.Text(
                    'CERTIFICATIONS',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),
                ...resume.certificates.map(
                  (cert) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 8),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          cert.name,
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          '${cert.issuer} | ${cert.date}',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
      ),
    );
  }

  // Template 2: Classic - Sections with colored backgrounds and black text
  static void _addClassicTemplate(
    pw.Document pdf,
    Resume resume,
    PdfColor color,
  ) {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        theme: pw.ThemeData.withFont(
          base: pw.Font.times(),
          bold: pw.Font.timesBold(),
        ),
        build:
            (context) => [
              // Name - Big and centered
              pw.Center(
                child: pw.Text(
                  resume.fullName.toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 28,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 8),

              // Contact info
              pw.Center(
                child: pw.Text(
                  [
                    resume.email,
                    resume.contact,
                    resume.linkedin,
                    if (resume.website.isNotEmpty) resume.website,
                  ].join(' | '),
                  style: const pw.TextStyle(fontSize: 11),
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Center(
                child: pw.Text(
                  resume.address,
                  style: const pw.TextStyle(fontSize: 11),
                ),
              ),
              pw.SizedBox(height: 20),

              // Description with colored background
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(8),
                decoration: pw.BoxDecoration(
                  color: color,
                  border: pw.Border(bottom: pw.BorderSide(width: 1)),
                ),
                child: pw.Text(
                  'PROFESSIONAL SUMMARY',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                resume.description,
                style: const pw.TextStyle(fontSize: 11),
              ),
              pw.SizedBox(height: 16),

              // Experience with colored background
              if (resume.experience.isNotEmpty) ...[
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    color: color,
                    border: pw.Border(bottom: pw.BorderSide(width: 1)),
                  ),
                  child: pw.Text(
                    'EXPERIENCE',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),
                ...resume.experience.map(
                  (exp) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 12),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          exp.position,
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          '${exp.company} | ${exp.startDate} - ${exp.currentlyWorking ? "Present" : exp.endDate}',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          exp.description,
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 16),
              ],

              // Skills with colored background
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(8),
                decoration: pw.BoxDecoration(
                  color: color,
                  border: pw.Border(bottom: pw.BorderSide(width: 1)),
                ),
                child: pw.Text(
                  'SKILLS',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                resume.skills.map((s) => s.name).join(' • '),
                style: const pw.TextStyle(fontSize: 11),
              ),
              pw.SizedBox(height: 16),

              // Education with colored background
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(8),
                decoration: pw.BoxDecoration(
                  color: color,
                  border: pw.Border(bottom: pw.BorderSide(width: 1)),
                ),
                child: pw.Text(
                  'EDUCATION',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ),
              pw.SizedBox(height: 8),
              ...resume.education.map(
                (edu) => pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 10),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        '${edu.degree} in ${edu.fieldOfStudy}',
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        '${edu.institution} | ${edu.startDate} - ${edu.endDate}',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                      if (edu.grade.isNotEmpty)
                        pw.Text(
                          'Grade: ${edu.grade}',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                    ],
                  ),
                ),
              ),

              // Certificates with colored background
              if (resume.certificates.isNotEmpty) ...[
                pw.SizedBox(height: 16),
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    color: color,
                    border: pw.Border(bottom: pw.BorderSide(width: 1)),
                  ),
                  child: pw.Text(
                    'CERTIFICATIONS',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),
                ...resume.certificates.map(
                  (cert) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 8),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          cert.name,
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          '${cert.issuer} | ${cert.date}',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
      ),
    );
  }

  // Template 3: Modern - Icons, colored text, bullet points
  static void _addModernTemplate(
    pw.Document pdf,
    Resume resume,
    PdfColor textColor,
  ) {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        theme: pw.ThemeData.withFont(
          base: pw.Font.times(),
          bold: pw.Font.timesBold(),
        ),
        build:
            (context) => [
              // Name
              pw.Text(
                resume.fullName.toUpperCase(),
                style: pw.TextStyle(
                  fontSize: 26,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 12),

              // Contact info in two columns
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          resume.address,
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                        pw.Text(
                          resume.contact,
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                        pw.Text(
                          resume.email,
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          resume.linkedin,
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                        if (resume.website.isNotEmpty)
                          pw.Text(
                            resume.website,
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),

              // Description
              pw.Text(
                resume.description,
                style: const pw.TextStyle(fontSize: 11),
              ),
              pw.SizedBox(height: 20),

              // Experience with icon and colored text
              if (resume.experience.isNotEmpty) ...[
                pw.Row(
                  children: [
                    pw.Text(
                      '■ ',
                      style: pw.TextStyle(fontSize: 16, color: textColor),
                    ),
                    pw.Text(
                      'EXPERIENCE',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
                ...resume.experience.map(
                  (exp) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 12, left: 20),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          children: [
                            pw.Text(
                              '• ',
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                            pw.Expanded(
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    exp.position,
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    '${exp.company} | ${exp.startDate} - ${exp.currentlyWorking ? "Present" : exp.endDate}',
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                  pw.SizedBox(height: 2),
                                  pw.Text(
                                    exp.description,
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 16),
              ],

              // Education with bullets
              pw.Row(
                children: [
                  pw.Text(
                    '■ ',
                    style: pw.TextStyle(fontSize: 16, color: textColor),
                  ),
                  pw.Text(
                    'EDUCATION',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 8),
              ...resume.education.map(
                (edu) => pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 10, left: 20),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('• ', style: const pw.TextStyle(fontSize: 14)),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              '${edu.degree} in ${edu.fieldOfStudy}',
                              style: pw.TextStyle(
                                fontSize: 11,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              '${edu.institution} | ${edu.startDate} - ${edu.endDate}',
                              style: const pw.TextStyle(fontSize: 10),
                            ),
                            if (edu.grade.isNotEmpty)
                              pw.Text(
                                'Grade: ${edu.grade}',
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(height: 16),

              // Skills with bullets
              pw.Row(
                children: [
                  pw.Text(
                    '■ ',
                    style: pw.TextStyle(fontSize: 16, color: textColor),
                  ),
                  pw.Text(
                    'SKILLS',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 8),
              ...resume.skills.map(
                (skill) => pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 4, left: 20),
                  child: pw.Row(
                    children: [
                      pw.Text('• ', style: const pw.TextStyle(fontSize: 14)),
                      pw.Text(
                        '${skill.name} (${skill.level})',
                        style: const pw.TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),

              // Certificates with bullets
              if (resume.certificates.isNotEmpty) ...[
                pw.SizedBox(height: 16),
                pw.Row(
                  children: [
                    pw.Text(
                      '■ ',
                      style: pw.TextStyle(fontSize: 16, color: textColor),
                    ),
                    pw.Text(
                      'CERTIFICATIONS',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
                ...resume.certificates.map(
                  (cert) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 8, left: 20),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('• ', style: const pw.TextStyle(fontSize: 14)),
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                cert.name,
                                style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.Text(
                                '${cert.issuer} | ${cert.date}',
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
      ),
    );
  }
}
