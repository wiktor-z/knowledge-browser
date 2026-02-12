def test_imports() -> None:
    from kb_core import Chunk, Entity, SourceDocument

    assert Chunk is not None
    assert Entity is not None
    assert SourceDocument is not None
