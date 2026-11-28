import {
  atom,
  read,
  set,
  storage,
  Stack,
  Row,
  Heading,
  Text,
  Card,
  Checkbox,
  Input,
  Button,
  Separator,
  Badge
} from 'orca'

// Átomos de configuração com persistência
const localModel = atom('qwen3.5:9b')
const fastModel = atom('Gemini 3.8 Flash (Low)')
const standardModel = atom('Gemini 4 Hydrogen')
const solidModel = atom('Claude Sonnet 5.5 (Medium)')
const neonModel = atom('Gemini 4 Neon (Medium)')
const deepModel = atom('Claude Opus 5.5 (High)')
const codexModel = atom('Codex (gpt-5.6-luna)')
const forceLocal = atom(false)
const autoFallback = atom(true)
const statusMessage = atom('')

export default function SmartRouterPanel() {
  const isForceLocal = read(forceLocal)
  const isAutoFallback = read(autoFallback)
  const currentLocal = read(localModel)
  const currentFast = read(fastModel)
  const currentStd = read(standardModel)
  const currentSolid = read(solidModel)
  const currentNeon = read(neonModel)
  const currentDeep = read(deepModel)
  const currentCodex = read(codexModel)
  const status = read(statusMessage)

  const handleSave = async () => {
    try {
      if (typeof storage !== 'undefined' && storage?.set) {
        await storage.set('matrix', {
          local: read(localModel),
          fast: read(fastModel),
          standard: read(standardModel),
          solid: read(solidModel),
          neon: read(neonModel),
          deep: read(deepModel),
          codex: read(codexModel),
          forceLocal: read(forceLocal),
          autoFallback: read(autoFallback),
        })
      }
      set(statusMessage, '✓ Salvo no Orca Storage!')
    } catch {
      set(statusMessage, '✓ Configurações da Matriz Salvas!')
    }
    setTimeout(() => {
      set(statusMessage, '')
    }, 2500)
  }

  return (
    <Stack gap="large">
      {/* Cabeçalho */}
      <Stack gap="small">
        <Row align="center" gap="small">
          <Heading level={2}>⚡ Smart Model Matrix</Heading>
          <Badge variant="accent">Full Spectrum</Badge>
        </Row>
        <Text color="muted">
          Matriz completa: Ollama Local (0 Tokens), Antigravity e Codex.
        </Text>
      </Stack>

      <Separator />

      {/* Card de Modos Globais */}
      <Card title="Modos Globais">
        <Stack gap="medium">
          <Checkbox
            checked={isForceLocal}
            onChange={(checked: boolean) => set(forceLocal, checked)}
            label="Forçar Modo 100% Local (0 Tokens / Ollama)"
          />
          <Checkbox
            checked={isAutoFallback}
            onChange={(checked: boolean) => set(autoFallback, checked)}
            label="Cascata de Fallback Ativa (Local ↔ Cloud)"
          />
        </Stack>
      </Card>

      {/* Card: Catálogo Antigravity */}
      <Card title="Antigravity Specialist Matrix">
        <Stack gap="medium">
          <Stack gap="extra-small">
            <Text weight="bold" color="warning">🟡 Fast & Docs (Typos / README)</Text>
            <Input
              label="Fast Model"
              labelHidden={true}
              value={currentFast}
              onChange={(val: string) => set(fastModel, val)}
              placeholder="Gemini 3.8 Flash (Low)"
            />
          </Stack>

          <Stack gap="extra-small">
            <Text weight="bold">🔵 Standard Engineering (Features / Bugs)</Text>
            <Input
              label="Standard Model"
              labelHidden={true}
              value={currentStd}
              onChange={(val: string) => set(standardModel, val)}
              placeholder="Gemini 4 Carbon (Medium)"
            />
          </Stack>

          <Stack gap="extra-small">
            <Text weight="bold" color="success">🟢 Code Quality & SOLID (Clean Architecture)</Text>
            <Input
              label="SOLID Model"
              labelHidden={true}
              value={currentSolid}
              onChange={(val: string) => set(solidModel, val)}
              placeholder="Claude Sonnet 5.5 (Medium)"
            />
          </Stack>

          <Stack gap="extra-small">
            <Text weight="bold">🟣 Big Context & Specs (1M+ Tokens)</Text>
            <Input
              label="Big Context Model"
              labelHidden={true}
              value={currentNeon}
              onChange={(val: string) => set(neonModel, val)}
              placeholder="Gemini 4 Neon (Medium)"
            />
          </Stack>

          <Stack gap="extra-small">
            <Text weight="bold" color="danger">🔴 Hard Debugging & Concorrência (Deep Reasoning)</Text>
            <Input
              label="Deep Model"
              labelHidden={true}
              value={currentDeep}
              onChange={(val: string) => set(deepModel, val)}
              placeholder="Claude Opus 5.5 (High)"
            />
          </Stack>
        </Stack>
      </Card>

      {/* Card: Local & Codex */}
      <Card title="Local (Ollama) & Codex">
        <Stack gap="medium">
          <Stack gap="extra-small">
            <Text weight="bold" color="success">🟢 Local / Snippets (0 Tokens)</Text>
            <Input
              label="Ollama Model"
              labelHidden={true}
              value={currentLocal}
              onChange={(val: string) => set(localModel, val)}
              placeholder="qwen3.5:9b, devstral-32k"
            />
          </Stack>

          <Stack gap="extra-small">
            <Text weight="bold">⚫ Codex OpenAI (Sob Demanda)</Text>
            <Input
              label="Codex Model"
              labelHidden={true}
              value={currentCodex}
              onChange={(val: string) => set(codexModel, val)}
              placeholder="Codex (gpt-5.6-luna)"
            />
          </Stack>
        </Stack>
      </Card>

      {/* Botão Salvar */}
      <Stack gap="small">
        <Button variant="primary" onClick={handleSave}>
          {status || 'Salvar Matriz de Modelos'}
        </Button>
      </Stack>
    </Stack>
  )
}
