# TODO

## Project

- [ ] more better tests
- [ ] simplifying coding in the project
- [ ] documentation
- [ ] support multiple DeclSyntax that need to visit their children in the same file 

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
- [x] ImportDeclSyntax - not working properly
- [x] VariableDeclSyntax
- [x] OperatorDeclSyntax - not tested
- [x] PrecedenceGroupDeclSyntax - not tested
- [x] SubscriptDeclSyntax

### DeclSyntax that need to visit their children:

- [ ] ClassDeclSyntax
- [ ] StructDeclSyntax
- [ ] ProtocolDeclSyntax
- [ ] ExtensionDeclSyntax
- [ ] EnumDeclSyntax - 50% the children part is not done

### DeclSyntax that I don't know what they represent:

- [ ] AccessorDeclSyntax
- [ ] IfConfigDeclSyntax
- [ ] PoundErrorDeclSyntax
- [ ] PoundWarningDeclSyntax
- [ ] PoundSourceLocationDeclSyntax

### DeclSyntax that might not need to be ordered:

- [ ] EnumCaseDeclSyntax
