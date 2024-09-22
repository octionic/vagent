// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownWidget extends StatefulWidget {
  const MarkdownWidget({
    Key? key,
    this.width,
    this.height, // Optional height parameter
    required this.textColor, // Renamed from mdcolor to textColor
    required this.content, // Renamed from data to content
  }) : super(key: key);

  final double? width;
  final double? height; // Optional height
  final String content; // Renamed from data to content
  final Color textColor; // Renamed from mdcolor to textColor

  @override
  _MarkdownWidgetState createState() => _MarkdownWidgetState();
}

class _MarkdownWidgetState extends State<MarkdownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      // Do not define height - let the content determine the height
      // Requires disabling "Enforce Width and Height" option in editor
      alignment: Alignment.topLeft, // Ensure alignment to top-left
      child: MarkdownBody(
        data: widget.content, // Renamed from data to content
        styleSheet: MarkdownStyleSheet(
          // Paragraph styling
          p: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: widget.textColor, // Set text color to textColor
              ),
          // List styling (bullet points)
          listBullet: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                color: widget.textColor, // Set bullet list color to textColor
              ),
          // Code block styling
          code: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                backgroundColor: Colors.transparent,
                fontFamily: 'monospace',
                fontSize: 14,
                color: widget.textColor, // Set code text color to textColor
              ),
          codeblockPadding: EdgeInsets.all(20),
          codeblockDecoration: BoxDecoration(
            color: widget.textColor
                .withOpacity(0.1), // Set background color for code blocks
          ),
          // Header styling for all levels
          h1: FlutterFlowTheme.of(context).titleLarge.copyWith(
                color: widget.textColor,
              ),
          h2: FlutterFlowTheme.of(context).titleMedium.copyWith(
                color: widget.textColor,
              ),
          h3: FlutterFlowTheme.of(context).titleSmall.copyWith(
                color: widget.textColor,
              ),
          h4: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                color: widget.textColor,
                fontSize: 20,
              ),
          h5: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: widget.textColor,
                fontSize: 18,
              ),
          h6: FlutterFlowTheme.of(context).bodySmall.copyWith(
                color: widget.textColor,
                fontSize: 16,
              ),
          // Horizontal line styling
          horizontalRuleDecoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    widget.textColor, // Set horizontal rule color to textColor
                width: 2, // Thickness of the line
              ),
            ),
          ),
          // Blockquote styling
          blockquoteDecoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: widget
                    .textColor, // Set blockquote left border color to textColor
                width: 4, // Thickness of the border
              ),
            ),
          ),
          blockquote: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: widget.textColor
                    .withOpacity(0.8), // Slightly lighter for blockquotes
                fontStyle: FontStyle.italic,
              ),
          // Emphasis (italic) styling
          em: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: widget.textColor,
                fontStyle: FontStyle.italic, // Italic text
              ),
          // Strong (bold) styling
          strong: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: widget.textColor,
                fontWeight: FontWeight.bold, // Bold text
              ),
          // Table styling (head and body)
          tableHead: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: widget.textColor,
                fontWeight: FontWeight.bold, // Bold for table headers
              ),
          tableBody: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: widget.textColor, // Normal color for table body
              ),
          // Link styling
          a: TextStyle(
            color: widget.textColor, // Link color
            decoration: TextDecoration.underline, // Underline links
          ),
        ),
        imageBuilder: (uri, title, alt) {
          return Padding(
            padding: const EdgeInsets.all(10.0), // Adding padding around images
            child: Image.network(uri.toString()),
          );
        },
      ),
    );
  }
}
