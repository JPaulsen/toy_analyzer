import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:secdart_analyzer/src/context.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    throw new ArgumentError('File path expected');
  }
  final path = args.first;
  final compilationUnit = resolveCompilationUnitHelper(path);
  toy_analyze(compilationUnit);
}

void toy_analyze(CompilationUnit compilationUnit) {
  final visitor = new ToyAnalyzerVisitor();
  compilationUnit.accept(visitor);
  print('This file has:');
  print('${visitor.classes} ${visitor.classes == 1 ? 'class' : 'classes'}.');
  print('${visitor.functions} ${visitor.functions == 1 ? 'function' : 'functions'}.');
  print('${visitor.methods} ${visitor.methods == 1 ? 'method' : 'methods'}.');
}

class ToyAnalyzerVisitor extends RecursiveAstVisitor {
  int classes = 0, functions = 0, methods = 0;

  @override
  visitClassDeclaration(ClassDeclaration node) {
    classes++;
    node.visitChildren(this);
  }

  @override
  visitFunctionDeclaration(FunctionDeclaration node) {
    functions++;
    node.visitChildren(this);
  }

  @override
  visitMethodDeclaration(MethodDeclaration node) {
    methods++;
    node.visitChildren(this);
  }
}
