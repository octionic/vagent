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
    this.height,
    required this.textColor,
    required this.content,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String content;
  final Color textColor;

  @override
  _MarkdownWidgetState createState() => _MarkdownWidgetState();
}

class _MarkdownWidgetState extends State<MarkdownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      alignment: Alignment.topLeft,
      child: MarkdownBody(
        data: widget.content,
        onTapLink: (text, href, title) {
          if (href != null) {
            launchURL(href);
          }
        },
        styleSheet: MarkdownStyleSheet(
          p: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: widget.textColor,
              ),
          listBullet: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                color: widget.textColor,
              ),
          code: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                backgroundColor: Colors.transparent,
                fontFamily: 'monospace',
                fontSize: 14,
                color: widget.textColor,
              ),
          codeblockPadding: EdgeInsets.all(20),
          codeblockDecoration: BoxDecoration(
            color: widget.textColor.withOpacity(0.1),
          ),
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
          horizontalRuleDecoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.textColor,
                width: 2,
              ),
            ),
          ),
          blockquoteDecoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: widget.textColor,
                width: 4,
              ),
            ),
          ),
          blockquote: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: widget.textColor.withOpacity(0.8),
                fontStyle: FontStyle.italic,
              ),
          em: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: widget.textColor,
                fontStyle: FontStyle.italic,
              ),
          strong: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: widget.textColor,
                fontWeight: FontWeight.bold,
              ),
          tableHead: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: widget.textColor,
                fontWeight: FontWeight.bold,
              ),
          tableBody: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: widget.textColor,
              ),
          a: TextStyle(
            color: FlutterFlowTheme.of(context).primary,
            decoration: TextDecoration.underline,
          ),
        ),
        imageBuilder: (uri, title, alt) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.network(uri.toString()),
          );
        },
      ),
    );
  }
}
