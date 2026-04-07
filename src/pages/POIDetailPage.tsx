import { useParams } from 'react-router-dom'

export default function POIDetailPage() {
  const { id } = useParams<{ id: string }>()

  return (
    <div className="p-4">
      <p className="text-alfabia-text-muted">POI {id} — TODO</p>
    </div>
  )
}
