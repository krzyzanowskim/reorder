# TODO

## Project

- [ ] more better tests
- [ ] simplifying coding in the project
- [ ] documentation

## Code Beautifiers

- [ ] newline between DeclSyntax to be homogenous
- [ ] sorting DeclSyntax
- [ ] more flexible sorting for accessLevels

## DeclSyntax Support:

### DeclSyntax that doesn't need to visit their children:

- [x] TypealiasDeclSyntax
- [x] AssociatedtypeDeclSyntax
- [x] FunctionDeclSyntax
- [x] InitializerDeclSyntax
- [x] DeinitializerDeclSyntax
- [x] ImportDeclSyntax
- [x] VariableDeclSyntax
- [x] OperatorDeclSyntax
- [x] PrecedenceGroupDeclSyntax

### DeclSyntax that need to visit their children:

- [ ] ClassDeclSyntax
- [ ] StructDeclSyntax
- [ ] ProtocolDeclSyntax
- [ ] ExtensionDeclSyntax
- [x] EnumDeclSyntax - 50% the children part is not done
- [] SubscriptDeclSyntax

### DeclSyntax that I don't know what they represent:

- [ ] AccessorDeclSyntax
- [ ] IfConfigDeclSyntax
- [ ] PoundErrorDeclSyntax
- [ ] PoundWarningDeclSyntax
- [ ] PoundSourceLocationDeclSyntax

### DeclSyntax that might not need to be ordered:

- [ ] EnumCaseDeclSyntax
