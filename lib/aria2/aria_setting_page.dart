import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'aria_setting_model.dart';

class AriaSettingPage extends StatelessWidget {
  const AriaSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AriaSettingModel(),
      lazy: false,
      child: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _domainController = TextEditingController();
  final _portController = TextEditingController();
  final _rpcPathController = TextEditingController();
  final _secretController = TextEditingController();
  final _downloadPathController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final config = context.read<AriaSettingModel>().config;
      _domainController.text = config.domain;
      _downloadPathController.text = config.downloadPath;
      _rpcPathController.text = config.rpcPath;
      _secretController.text = config.secret ?? '';
      _portController.text = config.port;
    });
  }

  @override
  void dispose() {
    _domainController.dispose();
    _portController.dispose();
    _rpcPathController.dispose();
    _secretController.dispose();
    _downloadPathController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aria2设置'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _UrlConfig(
              domainController: _domainController,
              rpcPathController: _rpcPathController,
              portController: _portController,
            ),
            const SizedBox(
              height: 16.0,
            ),
            _SecretConfig(
              secretController: _secretController,
            ),
            const SizedBox(
              height: 16.0,
            ),
            _DownloadPath(
              downloadPathController: _downloadPathController,
            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AriaSettingModel>().save(
                      domain: _domainController.text,
                      port: _portController.text,
                      rpcPath: _rpcPathController.text,
                      secret: _secretController.text,
                      downloadPath: _downloadPathController.text,
                      context: context,
                    );
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}

class _UrlConfig extends StatelessWidget {
  const _UrlConfig({
    required this.domainController,
    required this.portController,
    required this.rpcPathController,
  });
  final TextEditingController domainController;
  final TextEditingController portController;
  final TextEditingController rpcPathController;

  @override
  Widget build(BuildContext context) {
    return _Tile(
      title: 'RPC地址:',
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: domainController,
            decoration: const InputDecoration(
              hintText: '192.168.xx.xx',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            ':',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: portController,
            decoration: const InputDecoration(
              hintText: '6800',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            '/',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: rpcPathController,
            decoration: const InputDecoration(
              hintText: 'jsonrpc',
            ),
          ),
        ),
      ],
    );
  }
}

class _SecretConfig extends StatelessWidget {
  const _SecretConfig({required this.secretController});
  final TextEditingController secretController;

  @override
  Widget build(BuildContext context) {
    return _Tile(
      title: 'RPC密钥:',
      children: [
        Expanded(
          child: TextFormField(
            controller: secretController,
            obscureText: true,
            decoration: const InputDecoration(hintText: '******'),
          ),
        ),
      ],
    );
  }
}

class _DownloadPath extends StatelessWidget {
  const _DownloadPath({required this.downloadPathController});
  final TextEditingController downloadPathController;
  @override
  Widget build(BuildContext context) {
    return _Tile(
      title: '下载目录:',
      children: [
        Expanded(
          child: TextFormField(
            controller: downloadPathController,
            decoration: const InputDecoration(hintText: '/'),
          ),
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.title, required this.children});
  final String title;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          width: 16.0,
        ),
        ...children,
      ],
    );
  }
}
