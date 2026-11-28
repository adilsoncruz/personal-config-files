import {
  atom,
  read,
  set,
  Stack,
  Row,
  Heading,
  Text,
  Card,
  Input,
  Button,
  Separator,
  Badge
} from 'orca'

const targetPort = atom('3000')
const sandboxImage = atom('node:22-alpine')
const statusMessage = atom('')

export default function KiriMonitorPanel() {
  const port = read(targetPort)
  const image = read(sandboxImage)
  const status = read(statusMessage)

  const showCopyFeedback = (msg: string) => {
    set(statusMessage, msg)
    setTimeout(() => {
      set(statusMessage, '')
    }, 2500)
  }

  return (
    <Stack gap="large">
      {/* Cabeçalho */}
      <Stack gap="small">
        <Row align="center" gap="small">
          <Heading level={2}>🐳 Kiri Runtime</Heading>
          <Badge variant="accent">Linux & Tunnels</Badge>
        </Row>
        <Text color="muted">
          Ambiente de contêineres nativo, sandbox para agentes e túneis públicos.
        </Text>
      </Stack>

      <Separator />

      {/* Card de Status do Daemon */}
      <Card title="Status do Engine">
        <Stack gap="small">
          <Row align="center" gap="small">
            <Badge variant="success">● Ativo</Badge>
            <Text weight="bold">Docker Socket</Text>
          </Row>
          <Text size="small" color="muted">
            Socket: ~/.kiri/run/docker.sock (/var/run/docker.sock)
          </Text>
          <Text size="small" color="muted">
            Kernel: Linux 6.x nativo Apple Silicon via Kiri VM
          </Text>
        </Stack>
      </Card>

      {/* Card: Compartilhamento de Portas (orca-share) */}
      <Card title="⚡ Prévia Instantânea (orca-share)">
        <Stack gap="medium">
          <Text size="small">
            Expõe qualquer porta da worktree atual na internet com HTTPS instantâneo:
          </Text>
          <Row gap="small" align="center">
            <Input
              label="Porta"
              labelHidden={true}
              value={port}
              onChange={(val: string) => set(targetPort, val)}
              placeholder="3000"
            />
          </Row>
          <Text size="small" color="muted">
            Comando no terminal: <code>orca-share {port}</code>
          </Text>
        </Stack>
      </Card>

      {/* Card: Sandbox para Agentes (orca-sandbox) */}
      <Card title="🛡️ Sandbox Linux para Agentes">
        <Stack gap="medium">
          <Text size="small">
            Executa comandos ou builds do worktree isolados em container:
          </Text>
          <Input
            label="Imagem Padrão"
            labelHidden={true}
            value={image}
            onChange={(val: string) => set(sandboxImage, val)}
            placeholder="node:22-alpine, python:3.12-alpine"
          />
          <Text size="small" color="muted">
            Comando no terminal: <code>orca-sandbox -i {image}</code>
          </Text>
        </Stack>
      </Card>

      {/* Card: Ações Rápidas */}
      <Card title="Comandos Úteis">
        <Stack gap="small">
          <Text size="small">
            • <b>kiri ui</b>: abre o gerenciador visual nativo de containers.
          </Text>
          <Text size="small">
            • <b>orca-share status</b>: lista túneis ativos.
          </Text>
          <Text size="small">
            • <b>orca-sandbox</b>: abre shell isolado auto-detectando a stack.
          </Text>
        </Stack>
      </Card>

      {status ? (
        <Text weight="bold" color="success">
          {status}
        </Text>
      ) : null}
    </Stack>
  )
}
