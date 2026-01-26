import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:resumemaker/utilities/models.dart';

class PdfService {
  static Future<String> generatePdf(Resume resume, int templateType) async {
    final pdf = pw.Document();

    switch (templateType) {
      case 1:
        _addClassicTemplate(pdf, resume);
        break;
      case 2:
        _addModernTemplate(pdf, resume);
        break;
      case 3:
        _addMinimalTemplate(pdf, resume);
        break;
      default:
        _addClassicTemplate(pdf, resume);
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${resume.fullName}_resume.pdf');
    await file.writeAsBytes(await pdf.save());

    return file.path;
  }

  static void _addClassicTemplate(pw.Document pdf, Resume resume) {
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
              pw.Header(
                level: 0,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      resume.fullName,
                      style: pw.TextStyle(
                        fontSize: 28,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      resume.contact,
                      style: const pw.TextStyle(fontSize: 12),
                    ),
                    pw.Text(
                      resume.address,
                      style: const pw.TextStyle(fontSize: 12),
                    ),
                    if (resume.linkedin.isNotEmpty)
                      pw.Text(
                        'LinkedIn: ${resume.linkedin}',
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    if (resume.website.isNotEmpty)
                      pw.Text(
                        'Website: ${resume.website}',
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    pw.Divider(thickness: 2),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              if (resume.description.isNotEmpty) ...[
                pw.Text(
                  'SUMMARY',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  resume.description,
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.SizedBox(height: 20),
              ],
              if (resume.experience.isNotEmpty) ...[
                pw.Text(
                  'EXPERIENCE',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                ...resume.experience.map(
                  (exp) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 15),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          exp.position,
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          '${exp.company} | ${exp.startDate} - ${exp.currentlyWorking ? "Present" : exp.endDate}',
                          style: const pw.TextStyle(fontSize: 11),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          exp.description,
                          style: const pw.TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
              ],
              if (resume.education.isNotEmpty) ...[
                pw.Text(
                  'EDUCATION',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                ...resume.education.map(
                  (edu) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 15),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          '${edu.degree} in ${edu.fieldOfStudy}',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          '${edu.institution} | ${edu.startDate} - ${edu.endDate}',
                          style: const pw.TextStyle(fontSize: 11),
                        ),
                        if (edu.grade.isNotEmpty)
                          pw.Text(
                            'Grade: ${edu.grade}',
                            style: const pw.TextStyle(fontSize: 11),
                          ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
              ],
              if (resume.skills.isNotEmpty) ...[
                pw.Text(
                  'SKILLS',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Wrap(
                  spacing: 10,
                  runSpacing: 5,
                  children:
                      resume.skills
                          .map(
                            (skill) => pw.Container(
                              padding: const pw.EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColors.grey),
                                borderRadius: pw.BorderRadius.circular(5),
                              ),
                              child: pw.Text(
                                '${skill.name} (${skill.level})',
                                style: const pw.TextStyle(fontSize: 11),
                              ),
                            ),
                          )
                          .toList(),
                ),
                pw.SizedBox(height: 20),
              ],
              if (resume.certificates.isNotEmpty) ...[
                pw.Text(
                  'CERTIFICATES',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                ...resume.certificates.map(
                  (cert) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 10),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          cert.name,
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          '${cert.issuer} | ${cert.date}',
                          style: const pw.TextStyle(fontSize: 11),
                        ),
                        if (cert.credentialId.isNotEmpty)
                          pw.Text(
                            'ID: ${cert.credentialId}',
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

  static void _addModernTemplate(pw.Document pdf, Resume resume) {
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
              pw.Container(
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  color: PdfColors.blue50,
                  borderRadius: pw.BorderRadius.circular(10),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      resume.fullName,
                      style: pw.TextStyle(
                        fontSize: 32,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.blue900,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Row(
                      children: [
                        pw.Text(
                          '📞 ${resume.contact}',
                          style: const pw.TextStyle(fontSize: 11),
                        ),
                        pw.SizedBox(width: 20),
                        pw.Text(
                          '📍 ${resume.address}',
                          style: const pw.TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                    if (resume.linkedin.isNotEmpty || resume.website.isNotEmpty)
                      pw.Row(
                        children: [
                          if (resume.linkedin.isNotEmpty)
                            pw.Text(
                              '🔗 ${resume.linkedin}',
                              style: const pw.TextStyle(fontSize: 11),
                            ),
                          if (resume.website.isNotEmpty) ...[
                            pw.SizedBox(width: 20),
                            pw.Text(
                              '🌐 ${resume.website}',
                              style: const pw.TextStyle(fontSize: 11),
                            ),
                          ],
                        ],
                      ),
                  ],
                ),
              ),
              pw.SizedBox(height: 25),
              if (resume.description.isNotEmpty) ...[
                _modernSection('ABOUT ME', PdfColors.blue900),
                pw.SizedBox(height: 10),
                pw.Text(
                  resume.description,
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.SizedBox(height: 25),
              ],
              if (resume.experience.isNotEmpty) ...[
                _modernSection('PROFESSIONAL EXPERIENCE', PdfColors.blue900),
                pw.SizedBox(height: 10),
                ...resume.experience.map(
                  (exp) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 20),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                          width: 4,
                          height: 60,
                          color: PdfColors.blue900,
                        ),
                        pw.SizedBox(width: 15),
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                exp.position,
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.Text(
                                '${exp.company} | ${exp.startDate} - ${exp.currentlyWorking ? "Present" : exp.endDate}',
                                style: pw.TextStyle(
                                  fontSize: 11,
                                  color: PdfColors.grey700,
                                ),
                              ),
                              pw.SizedBox(height: 5),
                              pw.Text(
                                exp.description,
                                style: const pw.TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 25),
              ],
              if (resume.education.isNotEmpty) ...[
                _modernSection('EDUCATION', PdfColors.blue900),
                pw.SizedBox(height: 10),
                ...resume.education.map(
                  (edu) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 15),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          '${edu.degree} in ${edu.fieldOfStudy}',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          '${edu.institution} | ${edu.startDate} - ${edu.endDate}',
                          style: pw.TextStyle(
                            fontSize: 11,
                            color: PdfColors.grey700,
                          ),
                        ),
                        if (edu.grade.isNotEmpty)
                          pw.Text(
                            'Grade: ${edu.grade}',
                            style: const pw.TextStyle(fontSize: 11),
                          ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 25),
              ],
              if (resume.skills.isNotEmpty) ...[
                _modernSection('SKILLS', PdfColors.blue900),
                pw.SizedBox(height: 10),
                pw.Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children:
                      resume.skills
                          .map(
                            (skill) => pw.Container(
                              padding: const pw.EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: pw.BoxDecoration(
                                color: PdfColors.blue100,
                                borderRadius: pw.BorderRadius.circular(20),
                              ),
                              child: pw.Text(
                                skill.name,
                                style: pw.TextStyle(
                                  fontSize: 11,
                                  color: PdfColors.blue900,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
                pw.SizedBox(height: 25),
              ],
              if (resume.certificates.isNotEmpty) ...[
                _modernSection('CERTIFICATIONS', PdfColors.blue900),
                pw.SizedBox(height: 10),
                ...resume.certificates.map(
                  (cert) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 12),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          cert.name,
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          '${cert.issuer} | ${cert.date}',
                          style: pw.TextStyle(
                            fontSize: 11,
                            color: PdfColors.grey700,
                          ),
                        ),
                        if (cert.credentialId.isNotEmpty)
                          pw.Text(
                            'ID: ${cert.credentialId}',
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

  static pw.Widget _modernSection(String title, PdfColor color) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      decoration: pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: color, width: 2)),
      ),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 18,
          fontWeight: pw.FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  static void _addMinimalTemplate(pw.Document pdf, Resume resume) {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(50),
        theme: pw.ThemeData.withFont(
          base: pw.Font.times(),
          bold: pw.Font.timesBold(),
        ),
        build:
            (context) => [
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(
                      resume.fullName.toUpperCase(),
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      '${resume.contact} • ${resume.address}',
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                    if (resume.linkedin.isNotEmpty || resume.website.isNotEmpty)
                      pw.Text(
                        [
                          resume.linkedin,
                          resume.website,
                        ].where((s) => s.isNotEmpty).join(' • '),
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    pw.SizedBox(height: 20),
                    pw.Container(height: 1, width: 100, color: PdfColors.black),
                  ],
                ),
              ),
              pw.SizedBox(height: 30),
              if (resume.description.isNotEmpty) ...[
                pw.Text(
                  resume.description,
                  style: const pw.TextStyle(fontSize: 11),
                  textAlign: pw.TextAlign.justify,
                ),
                pw.SizedBox(height: 25),
              ],
              if (resume.experience.isNotEmpty) ...[
                pw.Text(
                  'EXPERIENCE',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                pw.SizedBox(height: 15),
                ...resume.experience.map(
                  (exp) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 20),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              exp.position,
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              '${exp.startDate} - ${exp.currentlyWorking ? "Present" : exp.endDate}',
                              style: const pw.TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        pw.Text(
                          exp.company,
                          style: const pw.TextStyle(fontSize: 11),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          exp.description,
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 25),
              ],
              if (resume.education.isNotEmpty) ...[
                pw.Text(
                  'EDUCATION',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                pw.SizedBox(height: 15),
                ...resume.education.map(
                  (edu) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 15),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              '${edu.degree} in ${edu.fieldOfStudy}',
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              '${edu.startDate} - ${edu.endDate}',
                              style: const pw.TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        pw.Text(
                          edu.institution,
                          style: const pw.TextStyle(fontSize: 11),
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
                pw.SizedBox(height: 25),
              ],
              if (resume.skills.isNotEmpty) ...[
                pw.Text(
                  'SKILLS',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                pw.SizedBox(height: 15),
                pw.Text(
                  resume.skills.map((s) => s.name).join(' • '),
                  style: const pw.TextStyle(fontSize: 11),
                ),
                pw.SizedBox(height: 25),
              ],
              if (resume.certificates.isNotEmpty) ...[
                pw.Text(
                  'CERTIFICATIONS',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                pw.SizedBox(height: 15),
                ...resume.certificates.map(
                  (cert) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 10),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              cert.name,
                              style: pw.TextStyle(
                                fontSize: 11,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              cert.date,
                              style: const pw.TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        pw.Text(
                          cert.issuer,
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
}
